import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/admin/widgets/users_admin_screen.dart';
import 'package:pasarela_app/screens/welcome_screen.dart';
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

    if (!mounted) return;

    setState(() {
      userData = data?['user'];
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
      appBar: AppBar(
        title: Text(userData != null
            ? "Bienvenido, ${userData!['name']}"
            : "Panel Administrador"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutConfirmationDialog(
                context), // 🔥 Muestra el diálogo de confirmación
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16), // Espaciado superior
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

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Cierre de Sesión"),
          content: const Text("¿Desea cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // 
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context); // 
                _logout(); // 
              },
              child: const Text("Cerrar Sesión",
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
