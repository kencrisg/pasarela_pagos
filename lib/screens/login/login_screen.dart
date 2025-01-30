import 'package:flutter/material.dart';
import 'package:pasarela_app/api/auth_service.dart';
import 'package:pasarela_app/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _adminCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false; //Variable para controlar la animación de carga

  void _login() async {
    setState(() {
      _isLoading = true; //Mostrar la animación de carga
    });

    bool success = await _authService.login(
      _adminCodeController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false; //Ocultar la animación de carga
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Login incorrecto")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: _adminCodeController,
                decoration: const InputDecoration(labelText: "Admin Code")),
            TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true),
            const SizedBox(height: 20),
            _isLoading // ✅ Mostrar el spinner si está cargando
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _login, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
