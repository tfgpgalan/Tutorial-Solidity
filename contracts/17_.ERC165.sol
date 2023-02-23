
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.00;
interface ERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

//import "./ERC165.sol" //Caso del interface en otro fichero;

contract ERC165MappingImplementation is ERC165 {
    /// @dev You must not set element 0xffffffff to true
    //Este mapeo lleva una lista de selectores de interface que son soportados por el sc.
    mapping(bytes4 => bool) internal supportedInterfaces;

    constructor()  {
        supportedInterfaces[this.supportsInterface.selector] = true;
    }

    function supportsInterface(bytes4 interfaceID) override external view returns (bool) {
        return supportedInterfaces[interfaceID];
    }
}