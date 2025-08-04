// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SwapPayWallet is ReentrancyGuard, Ownable {
    struct SwapParams {
        address tokenIn;
        address tokenOut;
        uint256 amountIn;
        uint256 minAmountOut;
        address recipient;
        uint256 deadline;
    }

    mapping(address => bool) public authorizedCallers;
    mapping(address => uint256) public nonces;
    
    event SwapExecuted(
        address indexed user,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOut
    );

    event AuthorizedCallerAdded(address indexed caller);
    event AuthorizedCallerRemoved(address indexed caller);

    modifier onlyAuthorized() {
        require(
            authorizedCallers[msg.sender] || msg.sender == owner(),
            "Not authorized"
        );
        _;
    }

    constructor() {
        authorizedCallers[msg.sender] = true;
    }

    function addAuthorizedCaller(address caller) external onlyOwner {
        authorizedCallers[caller] = true;
        emit AuthorizedCallerAdded(caller);
    }

    function removeAuthorizedCaller(address caller) external onlyOwner {
        authorizedCallers[caller] = false;
        emit AuthorizedCallerRemoved(caller);
    }

    function executeSwap(SwapParams calldata params) 
        external 
        onlyAuthorized 
        nonReentrant 
    {
        require(params.deadline >= block.timestamp, "Swap expired");
        require(params.amountIn > 0, "Invalid amount");

        // Transfer tokens from user
        IERC20(params.tokenIn).transferFrom(
            msg.sender,
            address(this),
            params.amountIn
        );

        // Execute swap logic here (integrate with OKX DEX API)
        uint256 amountOut = _performSwap(params);
        
        require(amountOut >= params.minAmountOut, "Insufficient output");

        // Transfer output tokens to recipient
        IERC20(params.tokenOut).transfer(params.recipient, amountOut);

        emit SwapExecuted(
            msg.sender,
            params.tokenIn,
            params.tokenOut,
            params.amountIn,
            amountOut
        );
    }

    function _performSwap(SwapParams calldata params) 
        internal 
        returns (uint256) 
    {
        // This would integrate with OKX DEX API off-chain
        // For demo purposes, return a mock amount
        return params.amountIn * 95 / 100; // 5% slippage simulation
    }

    function emergencyWithdraw(address token, uint256 amount) 
        external 
        onlyOwner 
    {
        IERC20(token).transfer(owner(), amount);
    }
}
