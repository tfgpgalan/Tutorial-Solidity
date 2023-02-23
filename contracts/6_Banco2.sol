// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Banco{

   address owner;
   modifier onlyOwner {
      require(msg.sender==owner,"NO ERES EL PROPIETARIO");
      _;
   }
   // payable: Para poder recibir dinero 
    constructor () payable  {
       owner = msg.sender;
    }
   //Cambiar el propietario
    function newOwner(address _newOwner) public onlyOwner {
       owner=_newOwner;
    } 
   //Devuelve la dirección del propietario del contrato. 
   //returns(tipo) indica el tipo valor que se va a devolver
   //view indica que es una función que no modifia el estado del contrato.
    function getOwner() view public returns(address) {
       return owner;
    }

    //Devuelve el saldo del contrato
    function getBalance() view public returns(uint256){
       return address(this).balance;
    }
    function incrementBalance(uint256 amount) payable public {
       require(msg.value==amount,"NO COINCIDEN CANTIDADES");
    }

    function withdrawBalance() public onlyOwner {
       payable(msg.sender).transfer(address(this).balance);
    }
}