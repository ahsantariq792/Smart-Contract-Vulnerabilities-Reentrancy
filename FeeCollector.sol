// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract FeeCollector{
    address public owner;
    uint256 public balance;

    constructor() public{
        owner = msg.sender;
    }

    receive() payable external {
         balance += msg.value;
    }
}