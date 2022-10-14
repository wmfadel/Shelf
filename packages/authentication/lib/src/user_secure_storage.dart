import 'dart:convert';

import 'package:domain_models/domain_models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


/// This class provides a secure way to store and retrieve user data in local storage.
class UserSecureStorage {
  static const _appUserKey = 'app-user';

  const UserSecureStorage({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  /// creates or updates local user data in secure storage
  Future<void> upsertUserInfo({required AppUser user}) async {
    _secureStorage.write(key: _appUserKey, value: jsonEncode(user.toJson()));
  }

  /// reads local user data from secure storage
  Future<AppUser?> getUserInfo() async {
    final userJson = await _secureStorage.read(key: _appUserKey);
    if (userJson == null) {
      return null;
    }
    return AppUser.fromJson(jsonDecode(userJson));
  }

  /// deletes local user data from secure storage
  Future<void> deleteUserInfo() async {
    await _secureStorage.delete(key: _appUserKey);
  }
}
