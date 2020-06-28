import 'package:flutter/material.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/screens/authentication/authenticate.dart';
import 'package:hack20/screens/ngoScreen/ngoScreen.dart';
import 'package:hack20/screens/user/homeScreen.dart';
import 'package:hack20/services/roleVerification.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      dynamic role = AccountVerification().checkRole(user.email);
      if (role == 'useraccess') {
        return HomeScreen();
      } else if (role == 'ngoaccess') {
        return NgoScreen();
      }
    }
  }
}
