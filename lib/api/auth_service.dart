import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'package:dio/dio.dart';


class AuthService {
  final ApiService _apiService = ApiService();

  Future<bool> login(String adminCode, String password) async {
  try {
    final response = await _apiService.dio.post(
      '/auth/login/admin',
      data: {"admin_code": adminCode, "password": password},
    );

    //print("✅ Login exitoso");
    final String token = response.data;

    //Guardamos el token en Shaared Preferences
    await _saveToken(token);

    return true;
  } on DioException catch (e) {
    //print("❌ Error en login: ${e.response?.data ?? e.message}");
    return false;
  }
}

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }
}