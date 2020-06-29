import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hack20/models/foodModel.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/shared/functions/dateTimeConversion.dart';
import 'package:hack20/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';

class UserFoodHistory extends StatefulWidget {
  @override
  _UserFoodHistoryState createState() => _UserFoodHistoryState();
}

class _UserFoodHistoryState extends State<UserFoodHistory> {
  final res = ResponseUI.instance;
  @override
  Widget build(BuildContext context) {

    zoomImage(String url) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              child: Image.network(url)
            )
          );
        }
      );
    }

    User user = Provider.of<User>(context);
    return StreamBuilder(
      stream: DatabaseService(email: user.email).userFoodHistory,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Food> foodData = snapshot.data;
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
                    child: Text('User History', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 3))
                ),
                SizedBox(height: 5),
                Divider(indent: 18, endIndent: 18, thickness: 1, height: 20, color: Colors.white),
                SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: foodData.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 300),
                        child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                                child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 5.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Container(
                                                        height: 124,
                                                        width: 400,
                                                        margin: EdgeInsets.only(left: 46),
                                                        decoration: BoxDecoration(
                                                            color: Color.fromRGBO(150, 170, 255, 0.9),
                                                            shape: BoxShape.rectangle,
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            boxShadow: [BoxShadow(color: Color.fromRGBO(100, 120, 255, 0.5), blurRadius: 10, offset: Offset(0, 10))]
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 35.0, top: 10.0),
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
                                                              foodData[index].hasBeenPickedUp ? Text('Picked up by ${foodData[index].pickedBy}', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)) :
                                                              Text('Not yet picked up', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
                                                              SizedBox(height: 3),
                                                              Text('${getDateAndTime(foodData[index].notifiedTime)}', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400))
                                                            ],
                                                          ),
                                                        )
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.symmetric(vertical: 16.0),
                                                        alignment: FractionalOffset.centerLeft,
                                                        child: Container(
                                                            height: 90, width: 75,
                                                            child: FittedBox(
                                                              child: GestureDetector(
                                                                child: Image.network(foodData[index].imageUrl),
                                                                onTap: () {zoomImage(foodData[index].imageUrl);},
                                                              ),
                                                            )
                                                        )
                                                    )
                                                  ],
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                )
                            )
                        )
                    );
                  },
                )
              ],
            )
          );
        } else {return Loading();}
      }
    );
  }
}
