import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemeHelper {
  static const String _themeKey = "theme_mode";

  static Future<void> saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, themeMode.index);
  }

  static Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt(_themeKey);

    // ✅ Si `themeIndex` es `null`, devolver `ThemeMode.system`
    return themeIndex != null ? ThemeMode.values[themeIndex] : ThemeMode.system;
  }
}
