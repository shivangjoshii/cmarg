import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const _kOnboardingKey = 'has_seen_onboarding';
  static const _kAuthTokenKey = 'auth_jwt';

  static Future<void> setOnboardingSeen() async =>
      await _storage.write(key: _kOnboardingKey, value: 'true');

  static Future<bool> hasSeenOnboarding() async {
    final val = await _storage.read(key: _kOnboardingKey);
    return val == 'true';
  }

  static Future<void> saveToken(String token) async =>
      await _storage.write(key: _kAuthTokenKey, value: token);

  static Future<String?> getToken() async =>
      await _storage.read(key: _kAuthTokenKey);

  static Future<void> clearAuth() async =>
      await _storage.delete(key: _kAuthTokenKey);
}