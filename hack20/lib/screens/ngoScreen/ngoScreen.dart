import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/screens/ngoScreen/ngoAvailableFood.dart';
import 'package:hack20/screens/ngoScreen/ngoFoodHistory.dart';
import 'package:hack20/services/auth.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/shared/functions/displayToast.dart';
import 'package:provider/provider.dart';

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
    User user = Provider.of<User>(context);
    addressCheck = DatabaseService(uid: user.uid).userNgosAddressData;
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
                backgroundColor: Colors.red,
                icon: Icon(
                    Icons.dashboard,
                    color: Colors.black
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: Colors.red,
                ),
                title: Text('Home'),
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                    Icons.history,
                    color: Colors.black
                ),
                activeIcon: Icon(
                  Icons.history,
                  color: Colors.red,
                ),
                title: Text('History'),
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                    Icons.account_circle,
                    color: Colors.black
                ),
                activeIcon: Icon(
                  Icons.account_circle,
                  color: Colors.red,
                ),
                title: Text('Settings'),
              )
            ]
        ),
        body: _pageChange()
    );
  }

  _pageChange() {
    switch (currentIndex) {
      case 0:
        if (addressCheck == null) {
          showLongToast('Please add an address', 2);
          return Container();
        } else return NGOAvailableFood();
        break;
      case 1:
        return NGOFoodHistory();
        break;
      case 2:
        return Container(
            child: Center(child: Text('Profile'))
        );
        break;
    }
  }
}