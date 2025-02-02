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
    // Definir la parte izquierda: el logo
    final Widget leftPart = Center(
      child: Image.asset("assets/DavoPagosLogo.png", width: 250, height: 250)
          .animate()
          .moveY(begin: -100, end: 0, duration: 350.ms)
          .fadeIn(duration: 350.ms),
    );

    // Definir el contenido principal (mensaje y botón)
    final Widget contentPart = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: const Text(
            "¡Bienvenidos a DavoPagos!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ).animate().fadeIn(duration: 350.ms, delay: 300.ms),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(
              side: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: const Text("Iniciar Sesión"),
        )
            .animate()
            .moveY(begin: 50, end: 0, duration: 350.ms, delay: 600.ms)
            .fadeIn(duration: 350.ms),
      ],
    );

    // Definir el footer
    final Widget footer = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "About Us",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
            .animate()
            .fadeIn(duration: 350.ms, delay: 1000.ms)
            .moveY(begin: 20, end: 0, duration: 350.ms, delay: 600.ms),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.public,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => _launchURL("https://www.tu-pagina-web.com"),
            )
                .animate()
                .fadeIn(duration: 350.ms, delay: 600.ms)
                .moveY(begin: 20, end: 0, duration: 350.ms),
            const SizedBox(width: 20),
            IconButton(
              icon: Icon(
                Icons.code,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () =>
                  _launchURL("https://github.com/kencrisg/pasarela_pagos"),
            )
                .animate()
                .fadeIn(duration: 350.ms, delay: 600.ms)
                .moveY(begin: 20, end: 0, duration: 350.ms),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("DavoPagos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Para pantallas anchas (landscape)
          if (constraints.maxWidth > 600) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(child: leftPart),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        contentPart,
                        const SizedBox(height: 40),
                        footer,
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ConstrainedBox(
              constraints: BoxConstraints(
                // Se establece una altura mínima igual a la altura disponible (restando AppBar y padding)
                minHeight: MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Parte superior: logo y contenido principal
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          leftPart,
                          const SizedBox(height: 20),
                          contentPart,
                        ],
                      ),
                      // Footer al final, sin dejar un espacio excesivo
                      footer,
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
