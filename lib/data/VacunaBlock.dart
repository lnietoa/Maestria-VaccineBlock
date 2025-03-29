import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';
import '../data/constants.dart';



class Vacunablock extends ChangeNotifier{

  late Web3Client client;
  late Credentials credentials;
  late DeployedContract contract;
  late ContractFunction Vacunar;
  late ContractFunction getVacuna;
  static bool loading = true;
  var retorno;


  Vacunablock(context){
    initialize(context);
  }



  initialize(context) async {

    client = Web3Client(rpcUrl,Client(), socketConnector: (){
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    final abiStringFile = await DefaultAssetBundle.of(context).loadString("abis/Vacunacion.json");
    final abiJson = jsonDecode(abiStringFile);
    final abi = jsonEncode(abiJson["abi"]);

    final contractAddress = EthereumAddress.fromHex(abiJson["networks"]["5777"]["address"]);
    credentials = EthPrivateKey.fromHex(privateKey);
    contract = DeployedContract(ContractAbi.fromJson(abi, contractName), contractAddress);

    Vacunar = contract.function("Vacunar");
    getVacuna = contract.function("getVacuna");

  }

  Future<Map> getVacunar(String idTx) async{

    //final b = [[47, 231, 241, 122, 203, 247, 95, 116, 114, 113, 153, 140, 201, 243, 142, 108, 254, 164, 192, 83, 224, 247, 20, 185, 74, 113, 77, 175, 48, 124, 73, 249]];
    //final base32Encoder = Base32Encoder.encodeBytes(b.elementAt(0));

    //BigInt chanId = await client.getChainId();

    //loading = true;
    //notifyListeners();

    //String s = "0x6b0ade84defb36188b1603f878ffe1e27604819f9e286587041490635a8dd81e";
    //final base32Decoder = Base32Decoder.decode(s);

    //Uint8List id = Uint8List.fromList(base32Decoder);

    //await client.sendTransaction(
    //    credentials, Transaction.callContract(contract: contract,function: getVacuna,
     //   parameters: [id]),
       // chainId: chanId.toInt(),
       // fetchChainIdFromNetworkId: false
    //);
    //final Vacuna = await client.call(contract: contract, function: getVacuna, params: [id]) ;
    //client.call(contract: contract, function: getVacuna, params: [s]);
    var res = await client.getTransactionByHash(idTx);

    var lista = Map<dynamic,dynamic>();
    lista.addAll({'Bloque':res!.blockNumber.blockNum});
    lista.addAll({'Transaccion': res.transactionIndex});
    lista.addAll({'Contrato':res.to});

    loading = false;
    notifyListeners();

    return lista;
}

  Future<String> RegistrarBlock(String idMascota,String idClinica,String idDoctor,String nombreVacuna,String fechaVacuna, String laboratorio) async {

    BigInt chanId = await client.getChainId();

    loading = true;
    notifyListeners();

    //await client.sendTransaction(
    //  credentials,
    //  Transaction(
    //    from: EthereumAddress.fromHex('0x2e6727a77D49f222aC032d7D77D3CDE48093eAaB'),
    //    to: EthereumAddress.fromHex('0xE3f53077A3a0e2a189072b58217feCb3FdBe944C'),
      //maxGas: 100000,
      //  gasPrice: EtherAmount.inWei(BigInt.one),
    //    value: EtherAmount.fromInt(EtherUnit.ether, 1),
        //maxFeePerGas: EtherAmount.fromInt(EtherUnit.ether, 1),
         // EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
    //  ),
    //    chainId: 1337,
    //    fetchChainIdFromNetworkId: false
    //);

    var tx = await client.sendTransaction(
        credentials, Transaction.callContract(contract: contract,function: Vacunar,
        parameters: [idMascota,idClinica,idDoctor,'$nombreVacuna-$laboratorio',fechaVacuna]),
        chainId: chanId.toInt(),
        fetchChainIdFromNetworkId: false
    );

    //var r = await client.call(contract: contract, function: Vacunar, params: [idMascota,idClinica,idDoctor,'$nombreVacuna-$laboratorio',fechaVacuna]);

    //print(r);
    //print(r.elementAt(0));

    //final retorno = Base32Encoder.encodeNoPaddingBytes(r.elementAt(0));
    //encodeBytes(r.elementAt(0));

    //print(retorno);

    loading = false;
    notifyListeners();

    return tx;
  }

}
