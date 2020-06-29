import 'package:flutter/material.dart';
import 'package:response/response.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final res = ResponseUI.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: res.screenWidth,
      height: res.screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color.fromRGBO(99, 107, 255, 1), Color.fromRGBO(130, 136, 255, 0.9)]
        ),
      ),
      child: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 30, left: 15),
              child: Text('Home Screen', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 3))
          ),
          Divider(indent: 18, endIndent: 18, thickness: 1, height: 20, color: Colors.white),
        ],
      )
    );
  }
}
