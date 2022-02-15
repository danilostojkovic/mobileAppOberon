import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Al posto di questa pagina metti tutto quello che riguarda metamask, blockchain, ecc'),
      ),
    );
  }
}


/*
class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
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
                style: const TextStyle(color: Colors.blueGrey, fontSize: 36));
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
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.1, 0.4, 0.7, 0.9],
                              colors: [
                                Colors.black,
                                Colors.blueGrey.shade900,
                                Colors.blueGrey,
                                Colors.brown.shade200,
                              ]
                          )
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


*/