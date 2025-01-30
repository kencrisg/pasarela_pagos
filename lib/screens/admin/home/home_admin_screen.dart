import 'package:flutter/material.dart';
import 'package:pasarela_app/api/auth_service.dart';
import 'package:pasarela_app/screens/welcome_screen.dart';

class HomeAdminScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  HomeAdminScreen({super.key});

  void _logout(BuildContext context) async {
    await _authService.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
      (route) => false, // Elimina la pila de navegacion
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _logout(context)),
        ],
      ),
      body: const Center(child: Text("¡Bienvenido al sistema!")),
    );
  }
}
