// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract EtherStore {

    uint256 public withdrawalLimit = 1 ether;
    mapping(address => uint256) public lastWithdrawTime;
    mapping(address => uint256) public balances;

    function depositFunds() public payable {
      balances[msg.sender] += msg.value;
      (bool sent, ) = msg.sender.call{value: 1 ether}("");
      require(sent, "Failed to send Ether");
  }

    function withdrawFunds (uint256 _weiToWithdraw) public {
        require(balances[msg.sender] >= _weiToWithdraw);
        // limit the withdrawal
        require(_weiToWithdraw <= withdrawalLimit);
        // limit the time allowed to withdraw
        require(now >= lastWithdrawTime[msg.sender] + 1 weeks);
        // msg.sender.call{value: balances[msg.sender]}("");       

        (bool success,) = msg.sender.call{value: balances[msg.sender]}("");
        require(success, "receiver rejected ETH transfer");
        balances[msg.sender] -= _weiToWithdraw;
        lastWithdrawTime[msg.sender] = now;
    }
 }