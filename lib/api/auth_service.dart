// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:pasarela_app/utils/storage_helper.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  final StorageHelper _storageHelper = StorageHelper();

  Future<bool> login(String email, String password, String endpoint) async {
    String isAdmin = endpoint == '/auth/login/admin' ? 'admin_code' : 'email';
    try {
      final response = await _apiService.dio.post(
        endpoint,
        data: {isAdmin: email, "password": password},
      );

      print("✅ Login exitoso");

      final String token = response.data;
      await _storageHelper.saveToken(token);

      return true;
    } on DioException catch (e) {
      print("❌ Error en login: ${e.response?.data ?? e.message}");
      return false;
    }
  }
  
  Future<bool> isLoggedIn() async {
    final token = await _storageHelper.getToken();
    return token != null;
  }
}
