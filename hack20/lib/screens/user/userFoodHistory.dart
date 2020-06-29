import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hack20/models/foodModel.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/shared/functions/dateTimeConversion.dart';
import 'package:hack20/shared/loading.dart';
import 'package:provider/provider.dart';

class UserFoodHistory extends StatefulWidget {
  @override
  _UserFoodHistoryState createState() => _UserFoodHistoryState();
}

class _UserFoodHistoryState extends State<UserFoodHistory> {
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
          return ListView.builder(
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
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        width: 100, height: 100,
                                        child: GestureDetector(
                                          child: Image.network(foodData[index].imageUrl),
                                          onTap: () {
                                            zoomImage(foodData[index].imageUrl);
                                          },
                                        )
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(top: 10),
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(foodData[index].name, style: TextStyle(fontWeight: FontWeight.w600)),
                                            SizedBox(height: 3),
                                            Row(
                                              children: <Widget>[
                                                Text('Quantity:', style: TextStyle(fontWeight: FontWeight.w500)),
                                                SizedBox(width: 3),
                                                Text('${foodData[index].quantity}')
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text('Date & Time: ', style: TextStyle(fontWeight: FontWeight.w500)),
                                                SizedBox(width: 3),
                                                Text(getDateAndTime(foodData[index].notifiedTime))
                                              ],
                                            )
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              ),
                            )
                        )
                    )
                  )
              );
            },
          );
        } else {return Loading();}
      }
    );
  }
}
