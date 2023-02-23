// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Banco{

// payable: Para poder recibir dinero 
    constructor () payable  {

    }

    function incrementBalance(uint256 amount) payable public {
       require(msg.value==amount);
       
    }

    function getBalance() public {
       payable(msg.sender).transfer(address(this).balance);
    }
}