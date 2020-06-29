import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack20/screens/user/FoodRegisterScreen.dart';
import 'package:hack20/screens/user/profileScreen.dart';
import 'package:hack20/screens/user/userFoodHistory.dart';
import 'package:hack20/services/auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex;
  String title = 'Home Page';

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      if (index == 1) title = 'Food History';
      if (index == 2) title = 'Profile';
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('Log Out'),
              onPressed: () {
                AuthService().signOut();
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FoodRegisterScreen()));
          },
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(hasNotch: true, fabLocation: BubbleBottomBarFabLocation.end, opacity: 0.2, currentIndex: currentIndex, onTap: changePage, borderRadius: BorderRadius.vertical(top: Radius.circular(16)), elevation: 8.0, items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.dashboard, color: Colors.black),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.red,
            ),
            title: Text('Home'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.history, color: Colors.black),
            activeIcon: Icon(
              Icons.history,
              color: Colors.red,
            ),
            title: Text('History'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.account_circle, color: Colors.black),
            activeIcon: Icon(
              Icons.account_circle,
              color: Colors.red,
            ),
            title: Text('Settings'),
          )
        ]),
        body: _pageChange());
  }

  _pageChange() {
    switch (currentIndex) {
      case 0:
        return Container(child: Center(child: Text('Home Screen')));
        break;
      case 1:
        return Container(child: Center(child: Text('History')));
        break;
      case 2:
        return ProfileScreen();
        break;
    }
  }
}
