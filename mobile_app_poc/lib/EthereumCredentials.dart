import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:dart_web3/src/crypto/secp256k1.dart';
import 'package:dart_web3/dart_web3.dart';

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  WalletConnectEthereumCredentials({required this.provider});

  final EthereumWalletConnectProvider provider;

  @override
  Future<EthereumAddress> extractAddress() {
    // TODO: implement extractAddress
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    try {
      final hash = await provider.sendTransaction(
        from: transaction.from!.hex,
        to: transaction.to?.hex,
        data: transaction.data,
        gas: transaction.maxGas,
        gasPrice: transaction.gasPrice?.getInWei,
        value: transaction.value?.getInWei,
        nonce: transaction.nonce,
      );
      return hash;
    } catch (error) {
      return "Internal Error";
    }
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }
}
