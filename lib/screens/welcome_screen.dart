import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/admin/login/login_admin_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Davo Pagos")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Logo en la parte superior
            Image.asset(
              "assets/DavoPagosLogo.png", // 🔥 Ruta de la imagen
              width: 150, // ✅ Tamaño del logo
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),

            // ✅ Texto "Escoja su rol"
            const Text(
              "Escoja su rol:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 30),

            // ✅ Tarjeta para Administrador
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginAdminScreen()),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: 250,
                  height: 120,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    "Administrador",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Tarjeta para Usuario
            GestureDetector(
              onTap: () {
                // Aquí se navega al login de usuario
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: 250,
                  height: 120,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    "Usuario",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
