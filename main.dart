
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bozza_poc/home_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Chain',
      home: const HomePage(),
    );
  }
}




