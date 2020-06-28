import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NgoScreen extends StatefulWidget {
  @override
  _NgoScreenState createState() => _NgoScreenState();
}

class _NgoScreenState extends State<NgoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGO Screen')
      ),
      body: Center(
        child: Text('NGO Page')
      )
    );
  }
}
