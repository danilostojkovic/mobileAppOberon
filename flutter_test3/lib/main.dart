import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:dart_web3/dart_web3.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher.dart';

//String _url = "";
const String privateKey =
    'ae17644f94057fe74c4dd000b0f3594779bb05fc69b7edaabc34be2a77b08456';
const String rpcUrl = 'https://api.avax-test.network/ext/bc/C/rpc';
var addressHex = "";
var balance, session;

void main() async {
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
  Future<String> _value = Future.value("");

  @override
  initState() {
    super.initState();
    _value = _walletConnect();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _value,
      initialData: 'App Name',
      builder: (
        BuildContext context,
        AsyncSnapshot<String> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Visibility(
                visible: snapshot.hasData,
                child: Text(
                  "${snapshot.data}",
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                ),
              )
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            return Text("${snapshot.data}",
                style: const TextStyle(color: Colors.teal, fontSize: 36));
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}

Scaffold _buildScaffold(var uri) {
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
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () => _launchURL(uri),
                    child: const Text('Gradient'),
                  ),
                ],
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ));
}

Future<String> _walletConnect() async {
  var _uri;

  final connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: const PeerMeta(
      name: 'WalletConnect',
      description: 'WalletConnect Developer App',
      url: 'https://walletconnect.org',
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
        chainId: 43113, onDisplayUri: (uri) => {_uri = uri});
    return Future.value(session.toUri());
  }

  return Future.error("PORCA VACCA");
}

void _launchURL(var url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}
