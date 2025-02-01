import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/admin/home/users_admin_screen.dart';
import 'package:pasarela_app/screens/welcome_screen.dart';
import 'package:pasarela_app/utils/storage_helper.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

  @override
  MainAdminScreenState createState() => MainAdminScreenState();
}

class MainAdminScreenState extends State<MainAdminScreen> {
  final StorageHelper _storageHelper = StorageHelper();

  void _logout() async {
    await _storageHelper.logout();
    if (!mounted) {
      return;
    }

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
        title: const Text("Panel Administrador"),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Title(
              color: Colors.black,
              child: const Text(
                'Clientes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.8, // 🔥 Ajusta altura
              child: const UserAdminScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
