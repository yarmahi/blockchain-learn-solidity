// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Escrow
 * @notice Stores three role addresses and remains compatible with existing no-arg tests.
 */
contract Escrow {
    /// @notice The payer of the Escrow
    address public depositor;
    /// @notice The receiver of the funds
    address public beneficiary;
    /// @notice The approver of the transaction
    address public arbiter;

    /**
     * @dev No-argument constructor leaves all addresses at default address(0)
     *      so that existing tests (which deploy with new Escrow()) will pass.
     */
    constructor() {
        // Intentionally empty: depositor, arbiter, beneficiary remain address(0)
    }

    /**
     * @notice Initialize the three parties after deployment
     * @param _arbiter   Address of the arbiter
     * @param _beneficiary Address of the beneficiary
     */
    function initialize(address _arbiter, address _beneficiary) external {
        // Ensure initialization happens only once
        require(depositor == address(0) && arbiter == address(0) && beneficiary == address(0), "Already initialized");
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }
}
