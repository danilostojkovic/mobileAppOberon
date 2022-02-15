import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:dart_web3/dart_web3.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'escrow.g.dart';
import 'EthereumCredentials.dart';

const String rpcUrl = 'https://api.avax-test.network/ext/bc/C/rpc';
final EthereumAddress contractAddr =
    EthereumAddress.fromHex('0x1648471B1b56bd703de37216Aa298077628Dcf27');
var balance, session, account, escrow, credentials;
Barcode? result;
String barCodeResult = "";

void main() async {
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
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color.fromRGBO(27, 27, 27, 1.0),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          fontFamily: 'Poppins'
        ),
      ),
      home: const MyHomePage(title: 'ShopChain Mobile'),
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
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
        child: Center(
            child: Column(children: [
          _getButtons(),
        ])),
      ),
    );
  }

  _walletConnect() async {
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
          chainId: 43113,
          onDisplayUri: (uri) async => {print(uri), await launch(uri)});
    }

    setState(() {
      account = session.accounts[0];
    });
    if (account != null) {
      final client = Web3Client(rpcUrl, Client());
      EthereumWalletConnectProvider provider =
          EthereumWalletConnectProvider(connector);
      credentials = WalletConnectEthereumCredentials(provider: provider);
      escrow = Escrow(address: contractAddr, client: client);
    }
  }

  Column _getButtons() {
    if (account != null) {
      return Column(children: [
        SizedBox(
            height: 400,
            width: 400,
            child: Image.asset("assets/LogoShopChainTest5.png", scale: 2.0)),
        Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 10),
            child: Text(
              "Please select an option",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white24,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 22, fontFamily: 'Poppins'),
                ),
                onPressed: () {
                  Navigator.of(context).push(_createRoute1());
                },
                child: Text("Scan QR", style: TextStyle(fontSize: 20)),
              ),
              width: 140,
              height: 80,
            ),
            SizedBox(
              width: 20,
            ),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white24,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 22, fontFamily: 'Poppins'),
                ),
                onPressed: () {
                  Navigator.of(context).push(_createRoute3());
                },
                child: Text("Orders", style: TextStyle(fontSize: 20)),
              ),
              width: 140,
              height: 80,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ]);
    }
    return Column(children: [
      SizedBox(
          height: 400,
          width: 400,
          child: Image.asset(
            "assets/LogoShopChainTest5.png",
            scale: 2.0,
            color: Colors.white.withOpacity(0.25),
            colorBlendMode: BlendMode.modulate,
          )),
      Padding(
          padding: EdgeInsets.fromLTRB(50, 0, 50, 10),
          child: Text(
            "Welcome to ShopChain, please connect your wallet",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )),
      SizedBox(
        height: 30,
      ),
      Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white24,
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 22, fontFamily: 'Poppins'),
            ),
            onPressed: () async => _walletConnect(),
            child: const Text('Connect Wallet'),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      )
    ]);
  }

  Route _createRoute1() {
    // reset QRCode scan results
    result = null;
    barCodeResult = "";

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const QRScanPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  Route _createRoute3() {
    // reset QRCode scan results
    result = null;
    barCodeResult = "";

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          OrdersPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result == null)
                    const Padding(
                        child: Text('Scan a code...',
                            style: TextStyle(fontSize: 10)),
                        padding: EdgeInsets.all(5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                          child: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              if (snapshot.data != true) {
                                return ElevatedButton(
                                    onPressed: () async {
                                      await controller?.toggleFlash();
                                      setState(() {});
                                    },
                                    child: Icon(Icons.flash_off),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.black));
                              }
                              return ElevatedButton(
                                  onPressed: () async {
                                    await controller?.toggleFlash();
                                    setState(() {});
                                  },
                                  child:
                                      Icon(Icons.flash_on, color: Colors.black),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                  ));
                            },
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    if (barCodeResult == "") {
      setState(() {
        this.controller = controller;
      });
      controller.scannedDataStream.listen((scanData) {
        var count = 0;
        setState(() {
          result = scanData;
          if (count == 0) {
            count++;
            Navigator.of(context).pop();
            Navigator.of(context).push(_createRoute2());
            controller.pauseCamera();
            barCodeResult = result!.code!;
          }
        });
      });
    }
  }

  Route _createRoute2() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => QROrderPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class QROrderPage extends StatefulWidget {
  @override
  State<QROrderPage> createState() => _QROrderPageState();
}

class _QROrderPageState extends State<QROrderPage> {
  get mainAxisAlignment => null;

  @override
  Widget build(BuildContext context) {
    String QRresult = barCodeResult;
    String OrderBuyer = QRresult.split(":")[0];

    if (OrderBuyer != account) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
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
          child: Center(
            child: Column(
              children: [
                const Icon(Icons.error),
                const Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
                    child: Text(
                        "Careful!!! The wallet your logged in with is not the buyer of this order.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromRGBO(255, 0, 0, 100)))),
                SizedBox(
                  width: 300,
                  height: 100,
                  child: ElevatedButton(
                      onPressed: () => {
                            barCodeResult = "",
                            makeRoutePage(
                                context, MyHomePage(title: "ShopChain Mobile"))
                          },
                      child: const Text("Go back to home page",
                          style: TextStyle(fontSize: 25))),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      );
    }

    //List orders = escrow.getOrdersOfUser();
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Order"),
        ),
        body: Container(
          decoration: BoxDecoration(
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
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
              FutureBuilder(
                  future: _getOrder(int.parse(QRresult.split(":")[1])),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    dynamic order = snapshot.data;
                    String seller = order[2].toString();
                    seller = seller.substring(0, 5) +
                        " ... " +
                        seller.substring(seller.length - 5);
                    String buyer = order[1].toString();
                    buyer = buyer.substring(0, 5) +
                        " ... " +
                        buyer.substring(buyer.length - 5);
                    String orderID = order[0].toString();
                    String amount =
                        EtherAmount.fromUnitAndValue(EtherUnit.wei, order[3])
                            .getValueInUnit(EtherUnit.ether)
                            .toString();
                    String state = "";
                    Icon stateIcon;
                    switch (order[4].toString()) {
                      case "0":
                        state = "Created";
                        stateIcon = Icon(Icons.check_circle,
                            color: Colors.white, size: 50.0);
                        break;
                      case "1":
                        state = "Confirmed";
                        stateIcon =
                            Icon(Icons.verified, color: Colors.white, size: 50.0);
                        break;
                      case "2":
                        state = "Deleted";
                        stateIcon =
                            Icon(Icons.delete, color: Colors.white, size: 50.0);
                        break;
                      case "3":
                        state = "Asked Refund";
                        stateIcon = Icon(Icons.assignment_return,
                            color: Colors.white, size: 50.0);
                        break;
                      case "4":
                        state = "Refunded";
                        stateIcon =
                            Icon(Icons.reply, color: Colors.white, size: 50.0);
                        break;
                      default:
                        state = "Unknown State";
                        stateIcon =
                            Icon(Icons.error, color: Colors.white, size: 50.0);
                        break;
                    }
                    return Column(
                      children: [
                        Padding(
                          child: Row(
                            children: [
                              Icon(Icons.tag, color: Colors.white, size: 50.0),
                              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                              Text("Order ID: $orderID",
                                  style: TextStyle(fontSize: 22))
                            ],
                            //mainAxisAlignment: MainAxisAlignment.center
                          ),
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        ),
                        Padding(
                          child: Row(
                            children: [
                              Icon(Icons.person_outline_outlined,
                                  color: Colors.white, size: 50.0),
                              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                              Text("Seller: $seller",
                                  style: TextStyle(fontSize: 22))
                            ],
                            //mainAxisAlignment: MainAxisAlignment.center
                          ),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        ),
                        Padding(
                          child: Row(
                            children: [
                              Icon(Icons.person, color: Colors.white, size: 50.0),
                              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                              Text("Buyer: $buyer",
                                  style: TextStyle(fontSize: 22))
                            ],
                            //mainAxisAlignment: MainAxisAlignment.center
                          ),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        ),
                        Padding(
                          child: Row(
                            children: [
                              Padding(
                                  child: Image.asset("assets/LogoAvaxMin.png",
                                      scale: 5),
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0)),
                              Text("Amount: $amount",
                                  style: TextStyle(fontSize: 22)),
                            ],
                            //mainAxisAlignment: MainAxisAlignment.center
                          ),
                          padding: EdgeInsets.fromLTRB(26, 20, 20, 0),
                        ),
                        Padding(
                          child: Row(
                            children: [
                              stateIcon,
                              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                              Text("State: $state",
                                  style: TextStyle(fontSize: 22))
                            ],
                            //mainAxisAlignment: MainAxisAlignment.center
                          ),
                          padding: EdgeInsets.fromLTRB(22, 20, 20, 0),
                        ),
                        SizedBox(height: 50),
                        (state == "Created")
                            ? SizedBox(
                                child: ElevatedButton(
                                  onPressed: () async => _confirmOrder(orderID),
                                  child: Text("Confirm Order",
                                      style: TextStyle(fontSize: 22)),
                                ),
                                width: 200,
                                height: 75,
                              )
                            : SizedBox(height: 0),
                        (state == "Confirmed")
                            ? SizedBox(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white24,
                                    padding: const EdgeInsets.all(16.0),
                                    textStyle: const TextStyle(fontSize: 22, fontFamily: 'Poppins'),
                                  ),
                                  onPressed: () async => _confirmOrder(orderID),
                                  child: Text("Ask for Refund"),
                                ),
                                width: 200,
                                height: 75,
                              )
                            : SizedBox(height: 0),
                      ],
                    );
                  })
            ],
          ),
        ));
  }

  Future<void> _confirmOrder(String orderID) async {
    final transaction = Transaction(
      to: contractAddr,
      from: EthereumAddress.fromHex(account),
      value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 0),
    );

    launch("https://metamask.app.link/");

    String returned = await escrow.confirmOrder(BigInt.parse(orderID),
        credentials: credentials, transaction: transaction);
  }

  Future<dynamic> _getOrder(int id) async {
    List<dynamic> orders =
        await escrow.getOrdersOfUser(EthereumAddress.fromHex(account));
    dynamic thisOrder;
    orders.forEach((element) => {
          if ((element[0]).toString() == id.toString()) {thisOrder = element}
        });
    return thisOrder;
    //return orders.where((element) => element[0] == id);
  }

  void makeRoutePage(BuildContext context, Widget pageRef) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => pageRef),
        (Route<dynamic> route) => false);
  }
}

class OrdersPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        body: Container(
          decoration: BoxDecoration(
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
          child: Column(children:[
              SizedBox(height: 20,),
              Row( children: [
                  Container(
                    width: 30,
                    height: 50,
                    padding: const EdgeInsets.all(8),
                    child: const Text("ID"),
                    color: Colors.teal[100],
                  ),
                  Container(
                    width: 120,
                    height: 50,
                    padding: const EdgeInsets.all(8),
                    child: const Text('Seller'),
                    color: Colors.teal[200],
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    padding: const EdgeInsets.all(8),
                    child: const Text('Amount'),
                    color: Colors.teal[100],
                  ),
                  Container(
                    width: 120,
                    height: 50,
                    padding: const EdgeInsets.all(8),
                    child: const Text('State'),
                    color: Colors.teal[200],
                  ),],
                mainAxisAlignment: MainAxisAlignment.center,
                ),
              FutureBuilder(
                future: _getOrders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  dynamic orders = snapshot.data;
                  Column col = Column();
                  String seller = "";
                  String amount = "";
                  String state = "";
                  Set<String> states = {"Created", "Confirmed", "Deleted", "Asked Refund", "Refunded"};
                  orders.forEach((element) => {
                    seller = element[2].toString(),
                    amount = EtherAmount.fromUnitAndValue(EtherUnit.wei, element[3])
                                          .getValueInUnit(EtherUnit.ether)
                                          .toString(),
                    state = states.elementAt(element[4]),
                    col.children.add(SizedBox(height: 2,)),
                    col.children.add(
                      Row(children: [
                        Container(
                          width: 30,
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          child: Text(orders[0].toString()),
                          color: Colors.teal[100],
                        ),
                        Container(
                          width: 120,
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          child: Text(seller.substring(0, 5)+"..."+seller.substring(seller.length-5)),
                          color: Colors.teal[200],
                        ),
                        Container(
                          width: 80,
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          child: Text(amount),
                          color: Colors.teal[100],
                        ),
                        Container(
                          width: 120,
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          child: Text(state),
                          color: Colors.teal[200],
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,)
                    )
                  });
                  return col;
                }
              )
          ],),
          
          ),
        );
  }
  Future<List<dynamic>> _getOrders() async{
    List<dynamic> orders = await escrow.getOrdersOfUser(EthereumAddress.fromHex(account));
    return orders;
  }
  

}
