import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack20/services/auth.dart';

class NgoScreen extends StatefulWidget {
  @override
  _NgoScreenState createState() => _NgoScreenState();
}

class _NgoScreenState extends State<NgoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGO Screen'),
        actions: <Widget>[
          FlatButton(
            child: Text('Log Out', style: TextStyle(color: Colors.white)),
            onPressed: () {
              AuthService().signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Text('NGO Page')
      )
    );
  }
}
