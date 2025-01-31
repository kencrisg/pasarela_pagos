import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<bool> login(String email, String password, String endpoint) async {
    String isAdmin = endpoint == '/auth/login/admin' ? 'admin_code' : 'email';
    try {
      final response = await _apiService.dio.post(
        endpoint,
        data: {isAdmin: email, "password": password},
      );

      print("✅ Login exitoso");

      final String token = response.data;
      await _saveToken(token);

      return true;
    } on DioException catch (e) {
      print("❌ Error en login: ${e.response?.data ?? e.message}");
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    print("✅ Sesión cerrada correctamente");
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    print("🔒 Token guardado correctamente");
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
