import 'package:dio/dio.dart';
import 'api_service.dart';

class UserService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getUserTransactions(int userId) async {
    try {
      final response = await _apiService.dio.get('/user/transaction/$userId');
      return response.data;
    } on DioException catch (e) {
      print(
          "❌ Error al obtener transacciones: ${e.response?.data ?? e.message}");
      return [];
    }
  }
}
