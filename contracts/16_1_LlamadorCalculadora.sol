// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

//Sería el interface del otro contrato. Sería el abi del otro contrato.
contract Calculadora {
    function add(uint256 _x) public returns (uint256, address) {}
}

contract LlamadorCalculadora {
    //MUY IMPORTANTE EL ORDEN EXPLICACIÓN DESPUÉS
    uint256 public number;
    address public sender;
    Calculadora public c;
    address public _sc_Calc;

    constructor(address __sc_Calc) {
        c = Calculadora(__sc_Calc);
        _sc_Calc = __sc_Calc;
        number = 0;
    }

    // Utilizando el interface
    function addMethod(uint256 _x) external returns (uint256, address) {
        return c.add(_x);
    }

    //Sin utilizar el interface y sin el cast Calculadora()
    //Al utilizar call el scope será del otro contrato, o sea, el number del sc
    //Calculadora será el incrementado y el sender devuelto es el de este sc.
    function addCallMethod(uint256 _x) external returns (uint256, address) {
        //success indica si se ha ejecutado bien
        (bool success, bytes memory data) = 
            (_sc_Calc.call(abi.encodeWithSignature("add(uint256)", _x)));
            //Otra posibilidad de selector de función del otro sc sería:
            //_sc_Calc.call(byte4(keccak256(add(uint256))),_x);
        require(success, "Error");
        //desestructuramos data
        (uint256 num, address address_sender) = abi.decode(data, (uint256, address));
        return (num, address_sender);
    }

    //Sin utilizar el interface y sin el cast Calculadora()
    //Al utilizar delegatecall el scope será de este contrato o sea, el number incrementado
    //será el de este contrato y el sender devuelto es el de la cuenta externa llamadora
    function addDelegateCall(uint256 _x) external returns (uint256, address) {
        //success indica si se ha ejecutado bien
        (bool success, bytes memory data) = 
            (_sc_Calc.delegatecall(abi.encodeWithSignature("add(uint256)", _x)));

        require(success, "Error");
        //desestructuramos data
        (uint256 num, address address_sender) = abi.decode(data, (uint256, address));

        return (num, address_sender);
    }
}
