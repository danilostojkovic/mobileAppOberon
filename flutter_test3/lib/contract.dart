import 'package:dart_web3/dart_web3.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';

import 'escrow.g.dart';

const String rpcUrl = 'https://api.avax-test.network/ext/bc/C/rpc';

// private key buyer 1
const String privateKey =
    'f603a29a26ccc992cc66b2a871239f558e1d8fdde46134a6a62afbc87f60f2f0';

final EthereumAddress contractAddr =
    EthereumAddress.fromHex('0x1648471B1b56bd703de37216Aa298077628Dcf27');

Future<void> main() async {
  // establish a connection to the ethereum rpc node. The socketConnector
  // property allows more efficient event streams over websocket instead of
  // http-polls. However, the socketConnector property is experimental.
  final client = Web3Client(rpcUrl, Client());
  final credentials = EthPrivateKey.fromHex(privateKey);
  final ownAddress = await credentials.extractAddress();

  // read the contract abi and tell dart_web3 where it's deployed (contractAddr)
  final escrow = Escrow(address: contractAddr, client: client);

  // check our balance in MetaCoins by calling the appropriate function
  var balance = await escrow.getBalance();
  var amount = EtherAmount.fromUnitAndValue(EtherUnit.wei, balance)
      .getValueInUnit(EtherUnit.ether);
  print('We have $amount');

  //await escrow.confirmOrder(BigInt.from(16), credentials: credentials);
  var orders = await escrow.getOrdersOfUser(ownAddress);
  orders.forEach((order) => print(order));
  await client.dispose();
}
