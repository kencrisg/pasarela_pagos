import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/welcome_screen.dart';
import 'package:pasarela_app/screens/widgets/custom_drawer.dart';
import 'package:pasarela_app/screens/widgets/transaction_admin_screen.dart';
import 'package:pasarela_app/screens/user/widgets/user_report_screen.dart';
import 'package:pasarela_app/utils/storage_helper.dart';

class MainUserScreen extends StatefulWidget {
  const MainUserScreen({super.key});

  @override
  MainUserScreenState createState() => MainUserScreenState();
}

class MainUserScreenState extends State<MainUserScreen> {
  final StorageHelper _storageHelper = StorageHelper();
  bool _isUserDataLoaded = false;
  Map<String, dynamic>? userData;
  int userId = 0;
  int _currentIndex = 0; // 🔥 Índice del Bottom Navigation

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await _storageHelper.getUserData();
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() {
      userData = data;
      userId = data?['user']?['user_id'] ?? 0;
      _isUserDataLoaded = true;
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
      UserTransactionsScreen(userId: userId),
      UserReportScreen(userId: userId),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(userData != null
            ? "Bienvenido, ${userData!['user']['name']}"
            : "Panel Usuario"),
      ),
      drawer: CustomDrawer(
        userData: userData,
        onLogout: _logout,
      ),
      body: _isUserDataLoaded
          ? (userId != 0
              ? screens[_currentIndex] // 🔥 Renderiza la pantalla seleccionada
              : const Center(
                  child: Text("Error: No se pudo obtener el ID del usuario"),
                ))
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 🔥 Cambia la pantalla según la selección
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Transacciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reporte',
          ),
        ],
      ),
    );
  }
}
