import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'jwt_token');
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'jwt_token');
  }
}

class AuthService {}
