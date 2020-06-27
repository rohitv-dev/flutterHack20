import 'package:flutter/material.dart';
import 'package:hack20/homePage.dart';
import 'package:response/response.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Response(
      originalScreenHeight: 759,
      originalScreenWidth: 392,
      child: MaterialApp(
        title: 'Hack 20 App',
        home: HomePage()
      ),
    );
  }
}
