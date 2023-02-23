pragma solidity ^0.5.0;

contract IterableMapping {
    mapping(address => address) public users;
    uint256 public listSize;
    //address(1) es una dir 0x000....1
    address constant internal FIRST_ADDRESS = address(1);

//El primer elemento apunta a si mismo
    constructor() public {
        users[FIRST_ADDRESS] = FIRST_ADDRESS;
    }
//El mapeo no existe address(0) es una adress vacía 0x000...0
    function isInList(address _address) internal view returns(bool) {
        return users[_address] != address(0);
    }

    function getPrevUser(address _address) internal view returns(address) {
        address currentAddress = FIRST_ADDRESS;
        while(users[currentAddress] != FIRST_ADDRESS) {
            if(users[currentAddress] == _address) {
                return currentAddress;
            }
            currentAddress = users[currentAddress];
        }
        return FIRST_ADDRESS;
    }
//Lo suyo sería añadir eventos o devolución de true o false
//Añade el elemento al principio, delante del FIRST_ADDRESS
    function addUser(address _address) public {
        require(!isInList(_address), 'El usuario ya existe');
        users[_address] = users[FIRST_ADDRESS];
        users[FIRST_ADDRESS] = _address;
        listSize++;
    }
//El elemento previo de _address apuntará al siguiente de _address
    function removeUser(address _address) public {
        require(_address!=FIRST_ADDRESS,'Address reservada');
        require(isInList(_address), 'El usuario no existe');
        address prevUsuer = getPrevUser(_address);
        users[prevUsuer] = users[_address];
        users[_address] = address(0);
        listSize--;
    }

    function getAllUsers() public view returns(address[] memory) {
        address[] memory usersArray = new address[](listSize);
        address currentAddress = users[FIRST_ADDRESS];
        for(uint256 i = 0; currentAddress != FIRST_ADDRESS; i++) {
            usersArray[i] = currentAddress;
            currentAddress = users[currentAddress];
        }
        return usersArray;
    }
}
