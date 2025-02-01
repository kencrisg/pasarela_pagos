import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://192.168.1.33:3000'));

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _getToken();
        if (token != null) {
          options.headers['Authorization'] =
              token; // 🔥 Enviar solo el token sin "Bearer "
        }

        print("📤 Enviando petición a: ${options.uri}");
        print("🔑 Token enviado: ${options.headers['Authorization']}");

        return handler.next(options);
      },
      onError: (DioException e, handler) {
        print("❌ Error en la petición: ${e.response?.statusCode}");
        print("🔍 Respuesta del servidor: ${e.response?.data}");
        return handler.next(e);
      },
    ));

    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Dio get dio => _dio;
}
