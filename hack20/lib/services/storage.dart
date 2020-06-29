import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage _storage = FlutterSecureStorage();

addItem(String key, String value) async {
  return await _storage.write(key: key, value: value);
}

readItem(String key) async {
  var read = await _storage.read(key: key);
  return read;
}