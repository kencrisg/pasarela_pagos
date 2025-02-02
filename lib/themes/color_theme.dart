import 'package:flutter/material.dart';

// 🔥 Tema Claro (Material 3 Genera los Colores)
final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor:
        const Color.fromARGB(255, 29, 163, 74), // 🔥 Color Principal (Azul)
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

// 🔥 Tema Oscuro (Material 3 Genera los Colores)
final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor:
        const Color.fromARGB(255, 29, 163, 74), // 🔥 Color Principal (Azul)
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);
