import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/admin/widgets/users_admin_screen.dart';
import 'package:pasarela_app/screens/welcome_screen.dart';
import 'package:pasarela_app/screens/widgets/custom_drawer.dart';
import 'package:pasarela_app/utils/storage_helper.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

  @override
  MainAdminScreenState createState() => MainAdminScreenState();
}

class MainAdminScreenState extends State<MainAdminScreen> {
  final StorageHelper _storageHelper = StorageHelper();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await _storageHelper.getUserData();
    setState(() {
      userData = data;
    });
  }

  void _logout() async {
    await _storageHelper.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Se agrega un Drawer en el Scaffold
      drawer: CustomDrawer(
        userData: userData,
        onLogout: _logout, // 🔥 Pasa la función de logout al Drawer
      ),
      appBar: AppBar(
        // El leading se reemplaza por el ícono de menú automáticamente cuando se define un Drawer.
        title: Text(userData != null
            ? "Bienvenido, ${userData!['name']}"
            : "Panel Administrador"),
        actions: [
          // Opcional: puedes mantener el botón de logout aquí o quitarlo si ya está en el Drawer.
          // En este ejemplo, se quita para evitar duplicidad.
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'Lista de Clientes',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: UserAdminScreen(),
          ),
        ],
      ),
    );
  }
}
