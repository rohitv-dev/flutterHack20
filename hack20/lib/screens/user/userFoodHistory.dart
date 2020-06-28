import 'package:flutter/material.dart';
import 'package:hack20/models/foodModel.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/shared/loading.dart';
import 'package:provider/provider.dart';

class UserFoodHistory extends StatefulWidget {
  @override
  _UserFoodHistoryState createState() => _UserFoodHistoryState();
}

class _UserFoodHistoryState extends State<UserFoodHistory> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder(
      stream: DatabaseService(email: user.email).userFoodHistory,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Food> foodData = snapshot.data;
          return ListView.builder(
            itemCount: foodData.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Image.network(foodData[index].imageUrl),
                subtitle: Text(foodData[index].name),
              );
            },
          );
        } else {return Loading();}
      }
    );
  }
}
