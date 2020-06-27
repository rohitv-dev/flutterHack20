import 'package:flutter/material.dart';
import 'package:response/response.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var response = ResponseUI.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
              height: response.setHeight(200),
              width: response.setWidth(400),
              color: Colors.blue,
              child: Text(
                  'Hello',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
          ),
          SizedBox(height: response.setHeight(10)),
          Icon(
            Icons.email,
            size: response.setFontSize(20),
          )
        ],
      )),
    );
  }
}
