import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Davo Pagos Movíl',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 18, 204, 33)),
          useMaterial3: true,
        ),
        home: WelcomeScreen());
  }
}
