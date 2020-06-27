import 'package:flutter/material.dart';
import 'package:hack20/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hack 20 App',
      home: HomePage()
    );
  }
}
