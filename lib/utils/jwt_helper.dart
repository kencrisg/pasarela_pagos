import 'dart:convert';

import 'package:pasarela_app/utils/storage_helper.dart';

class JWTHelper {
  StorageHelper storageHelper = StorageHelper();
  static Map<String, dynamic>? decodeToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      final payload =
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      return json.decode(payload);
    } catch (e) {
      return null;
    }
  }

  static String getUserName(Map<String, dynamic>? data) {
    if (data == null) return "Usuario";

    if (data.containsKey('user')) {
      return data['user']?['name'] ?? "Usuario";
    }
    return data['admin']?['name'] ?? "Administrador";
  }

  static bool isAdmin(Map<String, dynamic>? data) {
    return data != null && data.containsKey('admin_id');
  }
}
