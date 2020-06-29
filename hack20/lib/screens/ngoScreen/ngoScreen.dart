import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/screens/ngoScreen/ngoAvailableFood.dart';
import 'package:hack20/screens/ngoScreen/ngoFoodHistory.dart';
import 'package:hack20/screens/user/profileScreen.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/shared/functions/displayToast.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';

class NgoScreen extends StatefulWidget {
  @override
  _NgoScreenState createState() => _NgoScreenState();
}

class _NgoScreenState extends State<NgoScreen> {
  int currentIndex;
  var addressCheck;

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
    final response = ResponseUI.instance;
    User user = Provider.of<User>(context);
    addressCheck = DatabaseService(uid: user.uid).userNgosAddressData;
    return Scaffold(
        bottomNavigationBar: BubbleBottomBar(
            hasNotch: false,
            fabLocation: BubbleBottomBarFabLocation.end,
            opacity: 0.2,
            currentIndex: currentIndex,
            onTap: changePage,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            elevation: 8.0,
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
            ]
        ),
        body: Container(
            child: _pageChange()
    )
    );
  }

  _pageChange() {
    switch (currentIndex) {
      case 0:
        return NGOAvailableFood();
        break;
      case 1:
        return NGOFoodHistory();
        break;
      case 2:
        return ProfileScreen();
        break;
    }
  }
}