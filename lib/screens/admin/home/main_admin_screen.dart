import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/admin/widgets/users_admin_screen.dart';
import 'package:pasarela_app/screens/welcome_screen.dart';
import 'package:pasarela_app/screens/widgets/custom_drawer.dart';
import 'package:pasarela_app/screens/admin/widgets/report_admin_screen.dart'; // 🔥 Importa la pantalla de reportes
import 'package:pasarela_app/utils/storage_helper.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

  @override
  MainAdminScreenState createState() => MainAdminScreenState();
}

class MainAdminScreenState extends State<MainAdminScreen> {
  final StorageHelper _storageHelper = StorageHelper();
  Map<String, dynamic>? userData;
  int _currentIndex = 0; // 🔥 Índice del Bottom Navigation

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
    final List<Widget> screens = [
      const UserAdminScreen(),
      const ReportAdminScreen(), 
    ];

    return Scaffold(
      drawer: CustomDrawer(
        userData: userData,
        onLogout: _logout,
      ),
      appBar: AppBar(
        title: Text(userData != null
            ? "Bienvenido, ${userData!['admin']['name']}"
            : "Panel Administrador"),
      ),
      body: screens[_currentIndex],

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
            icon: Icon(Icons.analytics),
            label: 'Reportes',
          ),
        ],
      ),
    );
  }
}
