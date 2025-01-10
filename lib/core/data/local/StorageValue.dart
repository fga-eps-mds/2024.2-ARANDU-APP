import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:aranduapp/core/log/Log.dart';

class StorageValue {
  static const String _authToken = "auth_token";
  static const String _refreshToken = "refresh_token";
  static const String _email = "email";
  static const String _name = "name";
  static const String _viewOnboardingCount = "view_onboarding_count";

  static StorageValue? _singleton;
  final FlutterSecureStorage storage;

  StorageValue._internal()
      : storage = const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true));

  factory StorageValue.getInstance() => _singleton ??= StorageValue._internal();

  Future<void> _setValue(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
    } catch (e) {
      Log.e("Error while setting $key: $e");
    }
  }

  Future<String?> _getValue(String key) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      Log.e("Error while getting $key: $e");
      return null;
    }
  }

  Future<void> setAuthToken(String token) => _setValue(_authToken, token);
  Future<void> setRefreshToken(String token) => _setValue(_refreshToken, token);
  Future<void> setEmail(String email) => _setValue(_email, email);
  Future<void> setName(String name) => _setValue(_name, name);
  Future<void> setViewOnboardingCount(int count) =>
      _setValue(_viewOnboardingCount, count.toString());

  Future<String?> getAuthToken() => _getValue(_authToken);
  Future<String?> getRefreshToken() => _getValue(_refreshToken);
  Future<String?> getEmail() => _getValue(_email);
  Future<String?> getName() => _getValue(_name);
  Future<int?> getOnboardingCount() async =>
      int.tryParse(await _getValue(_viewOnboardingCount) ?? '');

  Future<void> clear() async {
    try {
      await storage.deleteAll();
    } catch (e) {
      Log.e("Error while clearing storage: $e");
    }
  }
}
