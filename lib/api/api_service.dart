// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pasarela_app/utils/storage_helper.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://192.168.1.39:3000'));
  final StorageHelper _storageHelper = StorageHelper();

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storageHelper.getToken();
        if (token != null) {
          options.headers['Authorization'] = token;
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

  Dio get dio => _dio;
}
