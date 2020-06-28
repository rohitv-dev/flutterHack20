import 'package:flutter/material.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/screens/wrapper.dart';
import 'package:hack20/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<User>.value(value: AuthService().user),
        ],
        child: Response(
          originalScreenHeight: 759,
          originalScreenWidth: 392,
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.white,
                buttonColor: Colors.pink
              ),
              title: 'Hack 20 App',
              home: Wrapper()),
        ));
  }
}
