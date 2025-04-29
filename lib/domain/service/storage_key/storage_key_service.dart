
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sola/global/encrypt_key/storage_key.dart';

class StorageKeyService {

  static final _storage = FlutterSecureStorage();

  static Future<void> saveSecretKey(String key) async {
    await _storage.write(key: StorageKey.keyStorageKey , value: key);
  }

  static Future<String?> getSecretKey() async {
    return _storage.read(key: StorageKey.keyStorageKey);
  }
}
