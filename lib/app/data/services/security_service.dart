import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static Future<void> saveToken(String token) async => await _storage.write(key: 'auth_jwt', value: token);
  static Future<String?> getToken() async => await _storage.read(key: 'auth_jwt');
  static Future<void> clearAuth() async => await _storage.delete(key: 'auth_jwt');
}