import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:math';
import 'package:dart_web3/dart_web3.dart';



const String privateKey =
  'ae17644f94057fe74c4dd000b0f3594779bb05fc69b7edaabc34be2a77b08456';
const String rpcUrl = 'https://api.avax-test.network/ext/bc/C/rpc';
var addressHex = "";
var balance;

void main() async{
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
        child: Column(children: [
          Image.asset("assets/LogoShopChainTest5.png"),
          Text("Address: ", style: TextStyle(fontSize: 20)), 
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text("$addressHex", style: TextStyle(fontSize: 30))
          ),
          Text("Balance:", style: TextStyle(fontSize: 20)), 
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text("$balance", style: TextStyle(fontSize: 30))
          )
          ,], 
          mainAxisAlignment: MainAxisAlignment.center,
        )
      )
    );
  }
}
