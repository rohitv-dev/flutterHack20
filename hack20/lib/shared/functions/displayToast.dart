import 'package:fluttertoast/fluttertoast.dart';

void showShortToast(String msg, int time) {
  Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: time);
}

void showLongToast(String msg, int time) {
  Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: time);
}
