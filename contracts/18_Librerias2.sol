// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

library L {
    function miAddress() internal view returns(address){
        return address(this);
    }
}
//
contract Main {
    function a() public view returns(address){
        //Devuelve el address de la librería porque sus funciones
        //son públicas. La llamada va a hacerse por delegateCall
        return L.miAddress();
    }
}
