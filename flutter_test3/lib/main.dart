import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:dart_web3/dart_web3.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'dart:developer';

const String privateKey =
    'ae17644f94057fe74c4dd000b0f3594779bb05fc69b7edaabc34be2a77b08456';
const String rpcUrl = 'https://api.avax-test.network/ext/bc/C/rpc';
var addressHex = "";
var balance, session;

void main() async {
  // Create a connector
  final connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: const PeerMeta(
      name: 'Metamask',
      description: 'WalletConnect Developer App',
      url: 'https://metamask.io/',
      icons: [
        'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
      ],
    ),
  );

  // Subscribe to events
  connector.on('connect', (session) => print(session));
  connector.on('session_update', (payload) => print(payload));
  connector.on('disconnect', (session) => print(session));

  // Create a new session
  if (!connector.connected) {
    session = await connector.createSession(
      chainId: 43113,
      onDisplayUri: (uri) => print(uri),
    );
    final sender = session.accounts[0];
  }

  session = session.toString();

  final client = Web3Client(rpcUrl, Client());

  final credentials = EthPrivateKey.fromHex(privateKey);
  final address = credentials.address;

  addressHex = address.hexEip55;

  balance = await client.getBalance(address);

  await client.dispose();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Applicazione Estremamente Complicata'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent.shade200,
        body: Center(
            child: Column(
          children: [
            Image.asset("assets/LogoShopChainTest5.png"),
            Text("Address: ", style: TextStyle(fontSize: 20)),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text("$addressHex", style: TextStyle(fontSize: 30))),
            Text("Balance:", style: TextStyle(fontSize: 20)),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text("$balance", style: TextStyle(fontSize: 30))),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )));
  }
}
