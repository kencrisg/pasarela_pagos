import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Davo Pagos Mobil',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 108, 53, 202)),
          useMaterial3: true,
        ),
        home: LoginScreen());
  }
}
