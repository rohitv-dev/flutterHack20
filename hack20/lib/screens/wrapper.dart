import 'package:flutter/material.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/screens/authentication/authenticate.dart';
import 'package:hack20/screens/ngoScreen/ngoScreen.dart';
import 'package:hack20/screens/user/homeScreen.dart';
import 'package:hack20/services/roleVerification.dart';
import 'package:hack20/shared/functions/networkCheck.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkNetwork();
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return FutureBuilder(
        future: checkLoginRole(user.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == 'useraccess') return HomeScreen();
            if (snapshot.data == 'ngoaccess') return NgoScreen();
          } else {return Container();}
        }
      );
    }
  }

  Future<String> checkLoginRole(String email) async {
    var role = await AccountVerification().checkRole(email);
    if (role == 'useraccess') {
      return 'useraccess';
    } else if (role == 'ngoaccess') {
      return 'ngoaccess';
    }
  }
}
