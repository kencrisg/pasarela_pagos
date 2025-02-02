import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 29, 163, 74),
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 29, 163, 74),
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);
