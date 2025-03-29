// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Vacunacion {

  address public owner;

  struct Vacuna {
    bytes32 idVacuna;
    string idMascota;
    string idClinica;
    string idDoctor;
    string nombreVacuna;
    string fechaVacuna;
  }

  //struct Hash {
  //  string idMascota;
  //  string idClinica;
  //  string idDoctor;
  //  string nombreVacuna;
  //  string fechaVacuna;
  //}


  Vacuna[] public vacunas;
  //Hash[] public hashes;
  bytes32 id;

  constructor() {
    owner = msg.sender;
  }

  function Vacunar(
    string calldata _idMascota,
    string calldata _idClinica,
    string calldata _idDoctor,
    string calldata _nombreVacuna,
    string calldata _fechaVacuna
  ) public
  returns(bytes32 idM){

  //  hashes.push(
  //    Hash({
  //      idMascota: _idMascota,
  //      idClinica: _idClinica,
  //      idDoctor: _idDoctor,
  //      nombreVacuna: _nombreVacuna,
  //      fechaVacuna: _fechaVacuna
  //    })
  //  );

  //  bytes memory hashBytes = abi.encode(hashes);

  //  id = keccak256(hashBytes);

    id = keccak256(abi.encodePacked(_idMascota,_idClinica,_idDoctor,_nombreVacuna,_fechaVacuna));

    vacunas.push(
      Vacuna({
        idVacuna: id,
        idMascota: _idMascota,
        idClinica: _idClinica,
        idDoctor: _idDoctor,
        nombreVacuna: _nombreVacuna,
        fechaVacuna: _fechaVacuna
      })
    );

    return id;
  }

  function getVacuna(bytes32 idVacuna)
  public
  view
  returns (Vacuna[] memory)
  {

    Vacuna[] memory result = new Vacuna[](1);
    for (uint i = 0; i < vacunas.length; i++) {
      if (vacunas[i].idVacuna == idVacuna){
        result[i] = vacunas[i];
      }
    }
    return result;
  }
}
