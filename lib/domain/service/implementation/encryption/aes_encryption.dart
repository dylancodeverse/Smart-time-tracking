import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sola/domain/service/interface/encryption/encryption.dart';
import 'package:sola/global/encrypt_key/storage_key.dart';
// ignore: depend_on_referenced_packages
import 'package:convert/convert.dart'; // pour convertir hex → bytes

class AESEncryption implements Encryption {
  final _storage = const FlutterSecureStorage();

  @override
  Future<String> encrypt(String data) async {
    final hexKey = await _storage.read(key: StorageKey.keyStorageKey);

    if (hexKey == null || hexKey.length != 64) {
      throw Exception('Clé AES invalide. Elle doit être une chaîne hexadécimale de 64 caractères.');
    }

    final keyBytes = hex.decode(hexKey); // convertit hexa en bytes
    final key = Key(Uint8List.fromList(keyBytes));

    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
    final encrypted = encrypter.encrypt(data);

    return encrypted.base64;
  }
}
