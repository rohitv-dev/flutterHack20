import 'package:flutter/material.dart';
import 'package:hack20/models/foodModel.dart';
import 'package:hack20/services/apiCall.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/services/storage.dart';
import 'package:hack20/shared/loading.dart';

class NGOAvailableFood extends StatefulWidget {
  @override
  _NGOAvailableFoodState createState() => _NGOAvailableFoodState();
}

class _NGOAvailableFoodState extends State<NGOAvailableFood> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().pendingFood,
      builder: (context, foodSnap) {
        List<Food> foodData = foodSnap.data;
        if (foodSnap.hasData) {
          return FutureBuilder(
            future: getDistance(),
            builder: (context, distance) {
              if (distance.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: foodData.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Text(foodData[index].name)
                    );
                  },
                );
              } else {return Loading();}
            }
          );
        } else {return Loading();}
      }
    );
  }

  getDistance() async {
    if (readItem('ngoDis') == null) {
      await APICall().callDistanceAPI();
      return readItem('ngoDis');
    } else {
      return readItem('ngoDis');
    }
  }
}
