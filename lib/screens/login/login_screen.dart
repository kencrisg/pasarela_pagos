import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pasarela_app/api/auth_service.dart';
import 'package:pasarela_app/screens/admin/home/main_admin_screen.dart';
import 'package:pasarela_app/screens/user/home/main_user_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isAdmin = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    String endpoint = _isAdmin ? '/auth/login/admin' : '/auth/login/user';

    try {
      bool success = await _authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        endpoint,
      );

      _emailController.clear();
      _passwordController.clear();

      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                _isAdmin ? const MainAdminScreen() : const MainUserScreen(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Credenciales incorrectas")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/DavoPagosLogo.png", width: 150, height: 150)
                  .animate()
                  .fadeIn(duration: 350.ms)
                  .moveY(begin: -30, end: 0, duration: 350.ms),
              const SizedBox(height: 20),
              const Text(
                "Iniciar Sesión",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ).animate().fadeIn(duration: 350.ms, delay: 300.ms),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Correo electrónico",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              )
                  .animate()
                  .fadeIn(duration: 350.ms, delay: 500.ms)
                  .moveX(begin: -30, end: 0, duration: 350.ms),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              )
                  .animate()
                  .fadeIn(duration: 350.ms, delay: 700.ms)
                  .moveX(begin: 30, end: 0, duration: 350.ms),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isAdmin,
                    onChanged: (value) {
                      setState(() {
                        _isAdmin = value!;
                      });
                    },
                  ),
                  const Text("¿Eres Administrador?"),
                ],
              )
                  .animate()
                  .fadeIn(duration: 350.ms, delay: 900.ms)
                  .moveX(begin: -20, end: 0, duration: 350.ms),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: const Text("Iniciar Sesión"),
                    )
                      .animate()
                      .fadeIn(duration: 350.ms, delay: 600.ms)
                      .moveY(begin: 30, end: 0, duration: 350.ms),
            ],
          ),
        ),
      ),
    );
  }
}
