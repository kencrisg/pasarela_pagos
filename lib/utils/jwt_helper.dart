import 'dart:convert';

import 'package:pasarela_app/utils/storage_helper.dart';

class JWTHelper {
  StorageHelper storageHelper = StorageHelper();
  static Map<String, dynamic>? decodeToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null; // No es un JWT válido
      }

      final payload =
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      return json.decode(payload);
    } catch (e) {
      print("❌ Error al decodificar el token: $e");
      return null;
    }
  }


}
