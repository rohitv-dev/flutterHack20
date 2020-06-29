import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(130, 140, 255, 1),
      child: Center(
        child: SpinKitChasingDots(
          color: Color.fromRGBO(220, 220, 255, 0.9),
          size: 50.0,
        ),
      ),
    );
  }
}
