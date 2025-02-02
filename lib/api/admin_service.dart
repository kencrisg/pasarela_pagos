import 'package:dio/dio.dart';
import 'package:pasarela_app/api/api_service.dart';

class AdminService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getUsers() async {
    try {
      final response = await _apiService.dio.get('/user');
      return response.data;
    } on DioException catch (e) {
      print("❌ Error al obtener usuarios: ${e.response?.data ?? e.message}");
      return [];
    }
  }

  Future<List<dynamic>> getUserTransactions(int userId) async {
    try {
      final response = await _apiService.dio.get('/user/transaction/$userId');

      print("✅ Transacciones obtenidas correctamente: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      print(
          "❌ Error al obtener transacciones: ${e.response?.data ?? e.message}");
      return [];
    }
  }
}
