import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/shared/functions/addDataWarning.dart';
import 'package:hack20/shared/functions/dateTimeConversion.dart';
import 'package:hack20/shared/loading.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/models/foodModel.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';

class NGOFoodHistory extends StatefulWidget {
  @override
  _NGOFoodHistoryState createState() => _NGOFoodHistoryState();
}

class _NGOFoodHistoryState extends State<NGOFoodHistory> {
  final res = ResponseUI.instance;

  zoomImage(String url) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(child: Container(child: Image.network(url)));
        });
  }

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
              if (!profSnap.hasData) return Loading();
              if (profSnap.data.userName == '')
                return displayAddData('Profile');
              return StreamBuilder(
                  stream: DatabaseService(ngoName: profSnap.data.userName)
                      .ngoFoodHistory,
                  builder: (context, ngoFoodSnap) {
                    if (ngoFoodSnap.hasData) {
                      List<Food> ngoFood = ngoFoodSnap.data;
                      return ListView(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 30, left: 15),
                              child: Text('NGO History',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 3))),
                          SizedBox(height: 5),
                          Divider(
                              indent: 18,
                              endIndent: 18,
                              thickness: 1,
                              height: 20,
                              color: Colors.white),
                          SizedBox(height: 5),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: ngoFood.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: Duration(milliseconds: 300),
                                    child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                            child: Container(
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        16.0,
                                                                    horizontal:
                                                                        5.0),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                    height: 124,
                                                                    width: 400,
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                46),
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromRGBO(
                                                                            150,
                                                                            170,
                                                                            255,
                                                                            0.9),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8.0),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Color.fromRGBO(100, 120, 255, 0.5),
                                                                              blurRadius: 10,
                                                                              offset: Offset(0, 10))
                                                                        ]),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              35.0,
                                                                          top:
                                                                              20.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Text(ngoFood[index].name, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 2)),
                                                                              SizedBox(width: 10),
                                                                              Text('x ${ngoFood[index].quantity}', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700))
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                              height: 5),
                                                                          Text(
                                                                              'Picked up on ${getDateAndTime(ngoFood[index].notifiedTime)}',
                                                                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
                                                                        ],
                                                                      ),
                                                                    )),
                                                                Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            16.0),
                                                                    alignment:
                                                                        FractionalOffset
                                                                            .centerLeft,
                                                                    child: Container(
                                                                        height: 90,
                                                                        width: 75,
                                                                        child: FittedBox(
                                                                          child:
                                                                              GestureDetector(
                                                                            child:
                                                                                Image.network(ngoFood[index].imageUrl),
                                                                            onTap:
                                                                                () {
                                                                              zoomImage(ngoFood[index].imageUrl);
                                                                            },
                                                                          ),
                                                                        )))
                                                              ],
                                                            )),
                                                      ],
                                                    ))))));
                              })
                        ],
                      );
                    } else {
                      return Loading();
                    }
                  });
            }));
  }
}
