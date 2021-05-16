import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hack20/models/foodModel.dart';
import 'package:hack20/models/sharedModel.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/services/apiCall.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/services/storage.dart';
import 'package:hack20/shared/functions/addDataWarning.dart';
import 'package:hack20/shared/functions/dateTimeConversion.dart';
import 'package:hack20/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';

class NGOAvailableFood extends StatefulWidget {
  @override
  _NGOAvailableFoodState createState() => _NGOAvailableFoodState();
}

class _NGOAvailableFoodState extends State<NGOAvailableFood> {
  final res = ResponseUI.instance;
  @override
  Widget build(BuildContext context) {
    zoomImage(String url) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(child: Container(child: Image.network(url)));
          });
    }

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
              if (!profSnap.hasData) return Loading();
              if (profSnap.data.userName == '') {
                return displayAddData('Profile');
              } else {
                UserProfile userProf = profSnap.data;
                return StreamBuilder<UserNGOAddress>(
                    stream: DatabaseService(uid: user.uid).userNgosAddressData,
                    builder: (context, adSnap) {
                      if (adSnap.hasData) {
                        UserNGOAddress addressData = adSnap.data;
                        if (addressData.latitude == 0.0)
                          return displayAddData('Address');
                        return StreamBuilder(
                            stream: DatabaseService().pendingFood,
                            builder: (context, foodSnap) {
                              List<Food> foodData = foodSnap.data;
                              if (foodSnap.hasData) {
                                return FutureBuilder(
                                    future: getDistance(addressData, foodData),
                                    builder: (context, distance) {
                                      if (distance.connectionState ==
                                          ConnectionState.done) {
                                        return ListView(
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 30, left: 15),
                                                child: Text('Home Screen',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                        letterSpacing: 3))),
                                            Divider(
                                                indent: 18,
                                                endIndent: 18,
                                                thickness: 1,
                                                height: 20,
                                                color: Colors.white),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 30),
                                                child: Text(
                                                    'Food Available To Be Picked Up',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white))),
                                            SizedBox(height: 5),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: foodData.length,
                                              itemBuilder: (context, index) {
                                                return AnimationConfiguration
                                                    .staggeredList(
                                                        position: index,
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        child: SlideAnimation(
                                                            verticalOffset:
                                                                50.0,
                                                            child: FadeInAnimation(
                                                                child: Container(
                                                                    child: Padding(
                                                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                                        child: Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 5.0),
                                                                                child: Stack(
                                                                                  children: <Widget>[
                                                                                    Container(
                                                                                        height: 124,
                                                                                        width: 400,
                                                                                        margin: EdgeInsets.only(left: 46),
                                                                                        decoration: BoxDecoration(color: Color.fromRGBO(150, 170, 255, 0.9), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                                                                                          BoxShadow(color: Color.fromRGBO(100, 120, 255, 0.5), blurRadius: 10, offset: Offset(0, 10))
                                                                                        ]),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.only(left: 35.0, top: 20.0),
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: <Widget>[
                                                                                              Row(
                                                                                                children: <Widget>[
                                                                                                  Text(foodData[index].name, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 2)),
                                                                                                  SizedBox(width: 10),
                                                                                                  Text('x ${foodData[index].quantity}', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700))
                                                                                                ],
                                                                                              ),
                                                                                              SizedBox(height: 5),
                                                                                              Text('Placed on ${getDateAndTime(foodData[index].notifiedTime)}', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
                                                                                              SizedBox(height: 5),
                                                                                              Text('${distance.data[index]}m away', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400)),
                                                                                              SizedBox(height: 10),
                                                                                              Padding(
                                                                                                  padding: EdgeInsets.only(left: 180),
                                                                                                  child: GestureDetector(
                                                                                                    child: Text('Pick Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                                                                                                    onTap: () async {
                                                                                                      await DatabaseService().foodPickedUp(foodData[index].id, true, userProf.userName, Timestamp.now());
                                                                                                    },
                                                                                                  ))
                                                                                            ],
                                                                                          ),
                                                                                        )),
                                                                                    Container(
                                                                                        margin: EdgeInsets.symmetric(vertical: 16.0),
                                                                                        alignment: FractionalOffset.centerLeft,
                                                                                        child: Container(
                                                                                            height: 90,
                                                                                            width: 75,
                                                                                            child: FittedBox(
                                                                                              child: GestureDetector(
                                                                                                child: Image.network(foodData[index].imageUrl),
                                                                                                onTap: () {
                                                                                                  zoomImage(foodData[index].imageUrl);
                                                                                                },
                                                                                              ),
                                                                                            )))
                                                                                  ],
                                                                                )),
                                                                          ],
                                                                        ))))));
                                              },
                                            )
                                          ],
                                        );
                                      } else {
                                        return Loading();
                                      }
                                    });
                              } else {
                                return Loading();
                              }
                            });
                      } else {
                        return Loading();
                      }
                    });
              }
            }));
  }

  Future getDistance(UserNGOAddress addressData, List<Food> foodData) async {
    await callDistanceAPI(addressData, foodData);
    return json.decode(await readItem('ngoDis'));
  }
}
