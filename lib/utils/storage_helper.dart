import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pasarela_app/utils/jwt_helper.dart';

class StorageHelper {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();


  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'jwt_token', value: token);

    final userData = JWTHelper.decodeToken(token);
    if (userData != null) {
      await _secureStorage.write(key: 'user_data', value: jsonEncode(userData));
    }
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'jwt_token');
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'jwt_token');
    await _secureStorage.delete(key: 'user_data');
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final userDataJson = await _secureStorage.read(key: 'user_data');
    if (userDataJson == null) return null;
    return jsonDecode(userDataJson);
  }
}

class AuthService {}
