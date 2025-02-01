import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/admin/home/transaction_admin_screen.dart';
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
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const UserAdminScreen(),
    const TransactionAdminScreen(),
  ];

  void _logout() async {
    await _storageHelper.logout();
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
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
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
