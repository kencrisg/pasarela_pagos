import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/welcome_screen.dart';
import 'package:pasarela_app/screens/widgets/transaction_admin_screen.dart';
import 'package:pasarela_app/utils/storage_helper.dart';
import 'package:pasarela_app/screens/widgets/logout_dialog.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(userData != null
            ? "Bienvenido, ${userData!['user']['name']}"
            : "Panel Usuario"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .secondary, // Puedes personalizar el fondo
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/DavoPagosLogo.png",
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    userData?['user']?['name'] ?? "Usuario",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuraciones"),
              onTap: () {
                Navigator.pop(context); // cierra el Drawer
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Cerrar Sesión",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                LogoutDialog.show(context, _logout);
              },
            ),
          ],
        ),
      ),
      body: _isUserDataLoaded
          ? (userId != 0
              ? UserTransactionsScreen(userId: userId)
              : const Center(
                  child: Text("Error: No se pudo obtener el ID del usuario")))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
