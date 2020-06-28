import 'dart:io';
import 'package:hack20/shared/functions/displayToast.dart';

Future<String> checkNetwork() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected to network');
      return "connectionSuccess";
    }
  } on SocketException catch (_) {
    print('no network');
    showShortToast("No internet Connection", 3);
  }
}
