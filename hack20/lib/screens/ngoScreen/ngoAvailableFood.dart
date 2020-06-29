import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hack20/models/foodModel.dart';
import 'package:hack20/models/sharedModel.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/services/apiCall.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/services/storage.dart';
import 'package:hack20/shared/loading.dart';
import 'package:provider/provider.dart';

class NGOAvailableFood extends StatefulWidget {
  @override
  _NGOAvailableFoodState createState() => _NGOAvailableFoodState();
}

class _NGOAvailableFoodState extends State<NGOAvailableFood> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserNGOAddress>(
      stream: DatabaseService(uid: user.uid).userNgosAddressData,
      builder: (context, adSnap) {
        if (adSnap.hasData) {
          UserNGOAddress addressData = adSnap.data;
          if (addressData.latitude == 0.0) return Center(child: Text('Please add an address'));
          return StreamBuilder(
              stream: DatabaseService().pendingFood,
              builder: (context, foodSnap) {
                List<Food> foodData = foodSnap.data;
                if (foodSnap.hasData) {
                  return FutureBuilder(
                      future: getDistance(addressData, foodData),
                      builder: (context, distance) {
                        if (distance.connectionState == ConnectionState.done) {
                          print(distance);
                          return ListView.builder(
                            itemCount: foodData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  child: Text(distance.data[index].toString())
                              );
                            },
                          );
                        } else {return Loading();}
                      }
                  );
                } else {return Loading();}
              }
          );
        } else {return Loading();}
      }
    );
  }

  Future getDistance(UserNGOAddress addressData, List<Food> foodData) async {
    await callDistanceAPI(addressData, foodData);
    return json.decode(await readItem('ngoDis'));
  }
}
