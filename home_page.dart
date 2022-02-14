import 'package:flutter/material.dart';
import 'package:bozza_poc/qr_scan_page.dart';
import 'package:bozza_poc/qr_create_page.dart';
import 'package:bozza_poc/connection_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //preferredSize: Size.fromHeight(200.0),
        //title: const Text('Shop Chain'),
        title: Image.asset('assets/LogoShopChainTest5.png', height: 100,),
        backgroundColor: Colors.black87,
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
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ConnectionPage()),
                      ); },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white24,
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
                    ),
                    child: const Text('Visualizza Transazioni')
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QRCreatePage()),
                      );
                      },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white24,
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
                    ),
                    child: const Text('Genera QR Code')
                ),
              ],
            ),
          ),
        ),
      ),


      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QRScanPage()),
          ); },
        child: Icon(Icons.qr_code_scanner),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color:Colors.blueGrey.shade800,
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.menu, color: Colors.white,), onPressed: () {},),
            IconButton(icon: Icon(Icons.person, color: Colors.white,), onPressed: () {},),
          ],
        ),
      ),
    );
  }
}