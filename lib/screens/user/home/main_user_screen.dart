import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/admin/widgets/users_admin_screen.dart';
import 'package:pasarela_app/screens/welcome_screen.dart';
import 'package:pasarela_app/utils/storage_helper.dart';

class MainUserScreen extends StatefulWidget {
  const MainUserScreen({super.key});

  @override
  MainUserScreenState createState() => MainUserScreenState();
}

class MainUserScreenState extends State<MainUserScreen> {
  final StorageHelper _storageHelper = StorageHelper();
  int _currentIndex = 0; // 🔥 Índice de la pantalla actual

  // 🔹 Lista de pantallas a mostrar según la selección del Navbar
  final List<Widget> _screens = [
    UserAdminScreen(), //Pantalla de Usuarios (inicial)
  ];

  void _logout() async {
    await _storageHelper.logout();
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panel Usuarioooo"),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),

      // 🔹 Muestra la pantalla actual según el _currentIndex
      body: _screens[_currentIndex],

      // 🔹 Navbar Inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 🔥 Cambia la pantalla al tocar un botón
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Transacciones',
          ),
        ],
      ),
    );
  }
}
