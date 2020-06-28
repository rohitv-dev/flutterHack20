import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage _storage = FlutterSecureStorage();

addItem(String key, String value) async {
  await _storage.write(key: key, value: value);
}

readItem(String key) async {
  return await _storage.read(key: key);
}