// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Calculadora {
    uint256 public number;
    address public sender;

    constructor() {
        number = 0;
    }

    function add(uint256 _x) public returns (uint256, address) {
        require(_x > 0 && _x < 10, "Error");
        sender=msg.sender;
        number+=_x;
        return(number,sender);
    }
}
