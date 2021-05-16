import 'package:flutter/material.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final res = ResponseUI.instance;
  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    return Container(
        width: res.screenWidth,
        height: res.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(99, 107, 255, 1),
                Color.fromRGBO(130, 136, 255, 0.9)
              ]),
        ),
        child: StreamBuilder<UserProfile>(
            stream: DatabaseService(uid: user.uid).userProfileData,
            builder: (context, profSnap) {
              if (!profSnap.hasData) {
                return Loading();
              }
              return ListView(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 30, left: 15),
                      child: Text('Welcome!',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 3))),
                  Divider(
                      indent: 18,
                      endIndent: 18,
                      thickness: 1,
                      height: 20,
                      color: Colors.white),
                  SizedBox(height: 30),
                  Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/theme.png'),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(height: 5),
                  profSnap.data.userName == ''
                      ? Column(
                          children: <Widget>[
                            Text('Create a Profile and Add Address',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 5),
                            Text('To Get Started',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))
                          ],
                        )
                      : Text('')
                ],
              );
            }));
  }
}
