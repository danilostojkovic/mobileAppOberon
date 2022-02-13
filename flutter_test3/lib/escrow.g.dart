// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:dart_web3/dart_web3.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address payable","name":"buyer","type":"address"},{"internalType":"address payable","name":"seller","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"enum Escrow.State","name":"state","type":"uint8"}],"indexed":false,"internalType":"struct Escrow.Order","name":"order","type":"tuple"}],"name":"orderConfirmed","type":"event"},{"anonymous":false,"inputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address payable","name":"buyer","type":"address"},{"internalType":"address payable","name":"seller","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"enum Escrow.State","name":"state","type":"uint8"}],"indexed":false,"internalType":"struct Escrow.Order","name":"order","type":"tuple"}],"name":"orderCreated","type":"event"},{"anonymous":false,"inputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address payable","name":"buyer","type":"address"},{"internalType":"address payable","name":"seller","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"enum Escrow.State","name":"state","type":"uint8"}],"indexed":false,"internalType":"struct Escrow.Order","name":"order","type":"tuple"}],"name":"orderDeleted","type":"event"},{"anonymous":false,"inputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address payable","name":"buyer","type":"address"},{"internalType":"address payable","name":"seller","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"enum Escrow.State","name":"state","type":"uint8"}],"indexed":false,"internalType":"struct Escrow.Order","name":"order","type":"tuple"}],"name":"orderRefunded","type":"event"},{"anonymous":false,"inputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address payable","name":"buyer","type":"address"},{"internalType":"address payable","name":"seller","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"enum Escrow.State","name":"state","type":"uint8"}],"indexed":false,"internalType":"struct Escrow.Order","name":"order","type":"tuple"}],"name":"refundAsked","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"seller","type":"address"}],"name":"sellerRegistered","type":"event"},{"inputs":[{"internalType":"uint256","name":"_orderID","type":"uint256"}],"name":"askRefund","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderID","type":"uint256"}],"name":"confirmOrder","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address payable","name":"_seller","type":"address"}],"name":"createOrder","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderID","type":"uint256"}],"name":"deleteOrder","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getBalance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getOrders","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address payable","name":"buyer","type":"address"},{"internalType":"address payable","name":"seller","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"enum Escrow.State","name":"state","type":"uint8"}],"internalType":"struct Escrow.Order[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_user","type":"address"}],"name":"getOrdersOfUser","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address payable","name":"buyer","type":"address"},{"internalType":"address payable","name":"seller","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"enum Escrow.State","name":"state","type":"uint8"}],"internalType":"struct Escrow.Order[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getSellers","outputs":[{"internalType":"address[]","name":"","type":"address[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getTotalOrders","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getTotalSellers","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderID","type":"uint256"}],"name":"refundBuyer","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"registerAsSeller","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
    'Escrow');

class Escrow extends _i1.GeneratedContract {
  Escrow(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> askRefund(BigInt _orderID,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'e47cad75'));
    final params = [_orderID];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> confirmOrder(BigInt _orderID,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '8ac7d79c'));
    final params = [_orderID];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> createOrder(_i1.EthereumAddress _seller,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'ea3774e3'));
    final params = [_seller];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> deleteOrder(BigInt _orderID,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '11a00327'));
    final params = [_orderID];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getBalance({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '12065fe0'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getOrders({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '2e2dc43e'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getOrdersOfUser(_i1.EthereumAddress _user,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '0d4b18e8'));
    final params = [_user];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<_i1.EthereumAddress>> getSellers({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '7ee454cb'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<_i1.EthereumAddress>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getTotalOrders({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '375f16a7'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getTotalSellers({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '245cd401'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, '8da5cb5b'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> refundBuyer(BigInt _orderID,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, '39292763'));
    final params = [_orderID];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> registerAsSeller(
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, '128b8532'));
    final params = [];
    return write(credentials, transaction, function, params);
  }

  /// Returns a live stream of all orderConfirmed events emitted by this contract.
  Stream<orderConfirmed> orderConfirmedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('orderConfirmed');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return orderConfirmed(decoded);
    });
  }

  /// Returns a live stream of all orderCreated events emitted by this contract.
  Stream<orderCreated> orderCreatedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('orderCreated');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return orderCreated(decoded);
    });
  }

  /// Returns a live stream of all orderDeleted events emitted by this contract.
  Stream<orderDeleted> orderDeletedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('orderDeleted');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return orderDeleted(decoded);
    });
  }

  /// Returns a live stream of all orderRefunded events emitted by this contract.
  Stream<orderRefunded> orderRefundedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('orderRefunded');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return orderRefunded(decoded);
    });
  }

  /// Returns a live stream of all refundAsked events emitted by this contract.
  Stream<refundAsked> refundAskedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('refundAsked');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return refundAsked(decoded);
    });
  }

  /// Returns a live stream of all sellerRegistered events emitted by this contract.
  Stream<sellerRegistered> sellerRegisteredEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('sellerRegistered');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return sellerRegistered(decoded);
    });
  }
}

class orderConfirmed {
  orderConfirmed(List<dynamic> response) : order = (response[0] as dynamic);

  final dynamic order;
}

class orderCreated {
  orderCreated(List<dynamic> response) : order = (response[0] as dynamic);

  final dynamic order;
}

class orderDeleted {
  orderDeleted(List<dynamic> response) : order = (response[0] as dynamic);

  final dynamic order;
}

class orderRefunded {
  orderRefunded(List<dynamic> response) : order = (response[0] as dynamic);

  final dynamic order;
}

class refundAsked {
  refundAsked(List<dynamic> response) : order = (response[0] as dynamic);

  final dynamic order;
}

class sellerRegistered {
  sellerRegistered(List<dynamic> response)
      : seller = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress seller;
}
