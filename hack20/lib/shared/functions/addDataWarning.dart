import 'package:flutter/material.dart';

Widget displayAddData(String word) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 30, left: 15),
          child: Text('Home Screen', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 3))
      ),
      Divider(indent: 18, endIndent: 18, thickness: 1, height: 20, color: Colors.white),
      Padding(
          padding: EdgeInsets.only(top: 200, left: 30),
          child: Text('Please Add $word Data In Profile Page', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500))
      )
    ],
  );
}