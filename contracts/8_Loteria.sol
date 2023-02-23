// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract  Loteria {
    address internal owner;
    uint256 internal num;
    uint256 public numGanador; 
    uint256 public precio; 
    bool public juegoactivo;
    address public ganador;
    event Premiado(bool acierto, uint256 numero);
// constructor con payable para que al deployarse se meta dinero en el balance del contrato haya un premio desde el inicio
    constructor(uint256 _numeroGanador, uint256 _precio)  payable { 
        owner = msg.sender;
        num = 0; //
        numGanador = _numeroGanador;
        precio = _precio; //Precio para participar
        juegoactivo = true; //juego activo o no, para dar de baja el sc.
    }

    function comprobarAcierto(uint256 _num) private view returns(bool){
        return (_num == numGanador);
    }

    function numeroRandom() private view returns(uint256){
        //keccak256 algoritmo de hash , abi.encode junta los tres parametros y los codifica.
        //block.timestamp variable global time de minado del bloque
        //num es el numero de participaciones que se han hecho
        return uint256( keccak256( abi.encode(block.timestamp, msg.sender, num))) % 2;
    }
    function participar() public payable returns (bool acierto , uint256 numUsuario)  {
        require(juegoactivo == true);
        require(msg.value == precio);
        
        numUsuario = numeroRandom();
        acierto = comprobarAcierto(numUsuario);
        //acierto=true;
        if (acierto == true){
          juegoactivo = false;
          uint256 premio=address(this).balance/2;
          payable(msg.sender).transfer(premio); // El ganador se lleva la mitad del bote
          ganador=msg.sender;
        } else {
            num++;
        }
       // return (acierto,numUsuario);
       //emit Premiado(acierto,numUsuario);
    }
    

    function verPremio() public view returns(uint256 premio){
        return address(this).balance/2;
    }
    //Al terminar el juego, el propietario se lleva la mitad de todo el bote
    function retirarFondosContrato() external returns(uint256 transferido){
        require(msg.sender==owner);
        require(juegoactivo==false);
        payable(msg.sender).transfer(address(this).balance);
        return address(this).balance;
    }
}