// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Demo {
    struct Todo {
        string name;
        bool isCompleted;
    }
    Todo[] public list; // 29414

    // 创建任务
    function create(string memory name_) external {
        list.push(
            Todo({
                name: name_, // ,
                isCompleted: false
            })
        );
    }

    // 修改任务名称
    function modiName1(uint256 index_, string memory name_) external {
        // 方法1: 直接修改，修改一个属性时候比较省 gas
        list[index_].name = name_;
    }

    function modiName2(uint256 index_, string memory name_) external {
        // 方法2: 先获取储存到 storage，在修改，在修改多个属性的时候比较省 gas
        Todo storage temp = list[index_];
        temp.name = name_;
    }

    // 修改完成状态1:手动指定完成或者未完成
    function modiStatus1(uint256 index_, bool status_) external {
        list[index_].isCompleted = status_;
    }

    // 修改完成状态2:自动切换 toggle
    function modiStatus2(uint256 index_) external {
        list[index_].isCompleted = !list[index_].isCompleted;
    }

    // 获取任务1: memory : 2次拷贝
    // 29448 gas
    function get1(uint256 index_)
        external
        view
        returns (string memory name_, bool status_)
    {
        Todo memory temp = list[index_];
        return (temp.name, temp.isCompleted);
    }

    // 获取任务2: storage : 1次拷贝
    // 预期：get2 的 gas 费用比较低（相对 get1）
    // 29388 gas
    function get2(uint256 index_)
        external
        view
        returns (string memory name_, bool status_)
    {
        Todo storage temp = list[index_];
        return (temp.name, temp.isCompleted);
    }
}
