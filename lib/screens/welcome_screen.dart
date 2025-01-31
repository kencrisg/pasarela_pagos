import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pasarela_app/screens/login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Logo con animación de caída
            Image.asset("assets/DavoPagosLogo.png", width: 250, height: 250)
                .animate()
                .moveY(begin: -100, end: 0, duration: 800.ms)
                .fadeIn(duration: 600.ms),

            const SizedBox(height: 20),

            // ✅ Texto con efecto fade-in
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "¡Bienvenidos a DavoPagos!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ).animate().fadeIn(duration: 1000.ms, delay: 400.ms),

            const SizedBox(height: 50),

            // ✅ Botón con animación de subida
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text("Iniciar Sesión"),
            )
                .animate()
                .moveY(begin: 50, end: 0, duration: 600.ms, delay: 800.ms)
                .fadeIn(duration: 600.ms),
          ],
        ),
      ),
    );
  }
}
