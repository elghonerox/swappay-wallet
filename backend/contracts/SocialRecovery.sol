// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SocialRecovery {
    address public owner;
    mapping(address => bool) public guardians;
    uint256 public guardianThreshold;
    mapping(address => mapping(address => bool)) public approvals;
    uint256 public approvalCount;
    bool public recoveryInProgress;
    address public proposedOwner;

    event GuardianAdded(address guardian);
    event GuardianRemoved(address guardian);
    event RecoveryStarted(address proposedOwner);
    event ApprovalReceived(address guardian);
    event RecoveryExecuted(address newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    modifier onlyGuardian() {
        require(guardians[msg.sender], "Only guardian");
        _;
    }

    constructor(address[] memory _guardians, uint256 _threshold) {
        require(_guardians.length >= _threshold, "Invalid threshold");
        owner = msg.sender;
        guardianThreshold = _threshold;

        for (uint256 i = 0; i < _guardians.length; i++) {
            guardians[_guardians[i]] = true;
            emit GuardianAdded(_guardians[i]);
        }
    }

    function addGuardian(address guardian) external onlyOwner {
        guardians[guardian] = true;
        emit GuardianAdded(guardian);
    }

    function removeGuardian(address guardian) external onlyOwner {
        guardians[guardian] = false;
        emit GuardianRemoved(guardian);
    }

    function startRecovery(address _proposedOwner) external onlyGuardian {
        require(!recoveryInProgress, "Recovery already in progress");
        proposedOwner = _proposedOwner;
        recoveryInProgress = true;
        approvalCount = 0;

        // Reset previous approvals
        for (uint256 i = 0; i < approvalCount; i++) {
            approvals[proposedOwner][msg.sender] = false;
        }

        emit RecoveryStarted(_proposedOwner);
    }

    function approveRecovery() external onlyGuardian {
        require(recoveryInProgress, "No recovery in progress");
        require(!approvals[proposedOwner][msg.sender], "Already approved");

        approvals[proposedOwner][msg.sender] = true;
        approvalCount++;

        emit ApprovalReceived(msg.sender);

        if (approvalCount >= guardianThreshold) {
            _executeRecovery();
        }
    }

    function _executeRecovery() internal {
        owner = proposedOwner;
        recoveryInProgress = false;
        proposedOwner = address(0);
        approvalCount = 0;

        emit RecoveryExecuted(owner);
    }
}
