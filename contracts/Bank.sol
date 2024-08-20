// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PiggyBank {
    address public owner;

    // 事件：存款事件和提款事件
    event Deposited(address indexed from, uint256 amount);
    event Withdrawn(address indexed to, uint256 amount);

    // 构造函数，设置合约所有者
    constructor() {
        owner = msg.sender; // 合约部署者为所有者
    }

    // 存款功能，允许任何人向合约中存钱
    function deposit() public payable {
        require(msg.value > 0, "Must send some Ether");
        emit Deposited(msg.sender, msg.value);
    }

    // 提款功能，只有所有者可以提取合约中的所有余额
    function withdraw() public {
        require(msg.sender == owner, "Not authorized"); // 只有所有者可以提款
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available");

        // 将合约中的所有余额转移给所有者
        payable(owner).transfer(balance);
        emit Withdrawn(owner, balance);
    }

    // 获取合约当前余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 接收以太币的函数，用于接收转账（与 deposit 功能类似）
    receive() external payable {
        emit Deposited(msg.sender, msg.value);
    }
}
