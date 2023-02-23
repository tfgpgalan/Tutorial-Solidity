// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Contador{
    uint256 count; // variable de estado
// Constructor, solo se llama a esta función en el deploy del SC
// En este caso inicializamos la variable global
    constructor(uint256 _count) { 
       count=_count;
    }
// Función con visibilidad publica accesible desde fuera
    function setCount (uint256 _count) public { 
       count=_count;
    }
// 
    function incrementCount() public{
       count+=1;
    }   
// Función de lectura de la variable. view le dice a la MV que está interpretando esta función, 
// que no va cambiar nada del estado del SC. Solo va a leer.
// returns para que sepa el tipo de valor devuelto.
    function getCount() public view returns(uint256){
        return count;
    }     
// pure: ni va a leer ni escribir en el estado del SC    
// Tano view como pure, no consumen gas.
    function getNumber() public pure returns(uint256){
        return 34;
    }

// Las funciones setter que modifican el estado consumen gas, si no mandamos el suficiente gas, el gas se consume
// pero la variable no se modifica.

}