// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

library MathLib {
    function add(uint256 _num1, uint256 _num2) internal pure returns (uint256) {
        return _num1 + _num2;
    }
}

contract Matematics {
    using MathLib for uint256; //A qué tipo de variable aplicarla

    function add(uint256 _n1, uint256 _n2) public pure returns (uint256) {
        return _n1.add(_n2);
        //return MathLib.add(_n1,_n2);
    }
}
