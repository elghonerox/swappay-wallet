// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract AccountAbstraction {
    using ECDSA for bytes32;

    struct UserOperation {
        address sender;
        uint256 nonce;
        bytes callData;
        uint256 callGasLimit;
        uint256 verificationGasLimit;
        uint256 preVerificationGas;
        uint256 maxFeePerGas;
        uint256 maxPriorityFeePerGas;
        bytes signature;
    }

    mapping(address => uint256) public nonces;
    mapping(address => address[]) public sessionKeys;
    mapping(address => mapping(address => bool)) public validSessionKeys;

    event UserOperationExecuted(address indexed user, bytes32 indexed userOpHash);
    event SessionKeyAdded(address indexed user, address indexed sessionKey);

    function addSessionKey(address sessionKey) external {
        require(!validSessionKeys[msg.sender][sessionKey], "Key already exists");
        
        sessionKeys[msg.sender].push(sessionKey);
        validSessionKeys[msg.sender][sessionKey] = true;
        
        emit SessionKeyAdded(msg.sender, sessionKey);
    }

    function executeUserOperation(UserOperation calldata userOp) external {
        bytes32 userOpHash = getUserOperationHash(userOp);
        
        // Verify signature
        address signer = userOpHash.recover(userOp.signature);
        require(
            signer == userOp.sender || validSessionKeys[userOp.sender][signer],
            "Invalid signature"
        );

        require(nonces[userOp.sender] == userOp.nonce, "Invalid nonce");
        nonces[userOp.sender]++;

        // Execute the operation
        (bool success,) = userOp.sender.call{gas: userOp.callGasLimit}(userOp.callData);
        require(success, "UserOp execution failed");

        emit UserOperationExecuted(userOp.sender, userOpHash);
    }

    function getUserOperationHash(UserOperation calldata userOp) 
        public 
        view 
        returns (bytes32) 
    {
        return keccak256(abi.encode(
            userOp.sender,
            userOp.nonce,
            keccak256(userOp.callData),
            userOp.callGasLimit,
            userOp.verificationGasLimit,
            userOp.preVerificationGas,
            userOp.maxFeePerGas,
            userOp.maxPriorityFeePerGas,
            block.chainid
        ));
    }
}
