import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  //final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000')); //local Host con dispositivos emulados
  //final Dio _dio = Dio(BaseOptions(baseUrl: 'http://172.20.142.84:3000')); //Server UTN
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://192.168.1.33:3000')); //LocalHost House
  //final Dio _dio = Dio(BaseOptions(baseUrl: 'https://192.168.190.38:3000')); //Server Deployado

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _getToken(); //Recuperamos el JWT si esq ya existe
        if (token != null) {
          options.headers['Authorization'] =
              'Bearer $token'; //Agregar token a cada request a la apiii
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          print("⚠️ Token inválido o expirado");
        }
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
