// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Bank {
    // 状态变量
    address public immutable owner;
    // 事件
    event Deposit(address _ads, uint256 amount);
    event Withdraw(uint256 amount);

    // receive
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // 构造函数
    constructor() payable {
        owner = msg.sender;
    }

    // 方法
    function withdraw() external {
        require(msg.sender == owner, "Not Owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
