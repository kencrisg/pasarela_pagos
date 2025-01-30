import 'package:flutter/material.dart';
import 'package:pasarela_app/api/auth_service.dart';
import 'package:pasarela_app/screens/admin/home/main_admin_screen.dart';

class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({super.key});

  @override
  LoginAdminScreenState createState() => LoginAdminScreenState();
}

class LoginAdminScreenState extends State<LoginAdminScreen> {
  final TextEditingController _adminCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false; // Controla la animación de carga
  bool _isPasswordVisible = false; //Controla la visibilidad de la contraseña

  void _login() async {
    setState(() {
      _isLoading = true; // Mostrar spinner
    });

    try {
      bool success = await _authService.login(
        _adminCodeController.text.trim(),
        _passwordController.text.trim(),
      );

      _adminCodeController.clear();
      _passwordController.clear();

      if (!mounted) return;
      setState(() {
        _isLoading = false; // Ocultar spinner
      });

      if (success) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeAdminScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ Credenciales incorrectas")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar Sesión - Administrador")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _adminCodeController,
              decoration: const InputDecoration(labelText: "Ingrese Código Admin:"),
            ),
            const SizedBox(height: 10),
            
            //Campo de contraseña con botón de mostrar/ocultar
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible, //Cambia la visibilidad del texto
              decoration: InputDecoration(
                labelText: "Ingrese Contraseña:",
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login, 
                    child: const Text("Iniciar Sesión"),
                  ),
          ],
        ),
      ),
    );
  }
}
