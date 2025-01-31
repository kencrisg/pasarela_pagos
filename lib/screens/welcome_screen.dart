import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pasarela_app/screens/login/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Función para abrir URLs
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir el enlace: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/DavoPagosLogo.png", width: 250, height: 250)
                  .animate()
                  .moveY(begin: -100, end: 0, duration: 800.ms)
                  .fadeIn(duration: 600.ms),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "¡Bienvenidos a DavoPagos!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ).animate().fadeIn(duration: 1000.ms, delay: 400.ms),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text("Iniciar Sesión"),
              )
                  .animate()
                  .moveY(begin: 50, end: 0, duration: 600.ms, delay: 800.ms)
                  .fadeIn(duration: 600.ms),
            ],
          ),

          // FOOTER APP
          Padding(
            padding: const EdgeInsets.only(bottom: 0, top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "About Us",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
                    .animate()
                    .fadeIn(duration: 1000.ms, delay: 1000.ms)
                    .moveY(begin: 20, end: 0, duration: 800.ms, delay: 1200.ms),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.public,
                          size: 30, color: Colors.black),
                      onPressed: () =>
                          _launchURL("https://www.tu-pagina-web.com"),
                    )
                        .animate()
                        .fadeIn(duration: 1000.ms, delay: 1400.ms)
                        .moveY(begin: 20, end: 0, duration: 800.ms),
                    const SizedBox(width: 20),
                    IconButton(
                      icon:
                          const Icon(Icons.code, size: 30, color: Colors.black),
                      onPressed: () =>
                          _launchURL("https://github.com/tu-repositorio"),
                    )
                        .animate()
                        .fadeIn(duration: 1000.ms, delay: 1600.ms)
                        .moveY(begin: 20, end: 0, duration: 800.ms),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
