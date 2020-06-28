import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack20/screens/user/FoodRegisterScreen.dart';
import 'package:hack20/screens/user/profileScreen.dart';
import 'package:hack20/services/auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text('Log Out'),
            onPressed: () {
              AuthService().signOut();
            },
          )
        ],
      ),
      body: ProfileScreen()
    );
  }
}
