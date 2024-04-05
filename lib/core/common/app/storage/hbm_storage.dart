
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HBMStorage {
  HBMStorage();

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  FlutterSecureStorage get storage => _storage;

  Future<void> writeData({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readData({required String key}) {
    return _storage.read(key: key);
  }

  Future<void> deleteData({required String key}) async {
    await _storage.delete(key: key);
  }
}
