import 'package:flutter/material.dart';
import 'package:hack20/shared/loading.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/models/foodModel.dart';

class NGOFoodHistory extends StatefulWidget {
  @override
  _NGOFoodHistoryState createState() => _NGOFoodHistoryState();
}

class _NGOFoodHistoryState extends State<NGOFoodHistory> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().ngoFoodHistory,
      builder: (context, ngoFoodSnap) {
        if (ngoFoodSnap.hasData) {
          List<Food> ngoFood = ngoFoodSnap.data;
          return ListView.builder(
            itemCount: ngoFood.length,
            itemBuilder: (context, index) {
              return Card(
                child: Text(ngoFood[index].name)
              );
            }
          );
        } else {return Loading();}
      }
    );
  }
}
