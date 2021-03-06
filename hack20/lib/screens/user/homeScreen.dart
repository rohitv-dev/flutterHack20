import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack20/screens/user/FoodRegisterScreen.dart';
import 'package:hack20/screens/user/profileScreen.dart';
import 'package:hack20/screens/user/userFoodHistory.dart';
import 'package:hack20/screens/user/userHomeScreen.dart';
import 'package:response/response.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex;
  final response = ResponseUI.instance;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FoodRegisterScreen()));
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(
            hasNotch: true, fabLocation: BubbleBottomBarFabLocation.end, opacity: 0.2, currentIndex: currentIndex, onTap: changePage, borderRadius: BorderRadius.vertical(top: Radius.circular(16)), elevation: 8.0,
            items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Color.fromRGBO(80, 90, 255, 1),
            icon: Icon(Icons.dashboard, color: Color.fromRGBO(50, 60, 255, 1)),
            activeIcon: Icon(
              Icons.dashboard,
              color: Color.fromRGBO(50, 60, 255, 1),
            ),
            title: Text('Home'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Color.fromRGBO(80, 90, 255, 1),
            icon: Icon(Icons.history, color: Color.fromRGBO(50, 60, 255, 1)),
            activeIcon: Icon(
              Icons.history,
              color: Color.fromRGBO(50, 60, 255, 1),
            ),
            title: Text('History'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Color.fromRGBO(80, 90, 255, 1),
            icon: Icon(Icons.account_circle, color: Color.fromRGBO(50, 60, 255, 1)),
            activeIcon: Icon(
              Icons.account_circle,
              color: Color.fromRGBO(50, 60, 255, 1),
            ),
            title: Text('Settings'),
          )
        ]),
        body: Container(
          child: _pageChange()
        )
    );
  }

  _pageChange() {
    switch (currentIndex) {
      case 0:
        return UserHomeScreen();
        break;
      case 1:
        return UserFoodHistory();
        break;
      case 2:
        return ProfileScreen();
        break;
    }
  }
}
