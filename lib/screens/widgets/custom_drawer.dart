import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/widgets/logout_dialog.dart';
import 'package:pasarela_app/utils/jwt_helper.dart'; // Importamos el helper

class CustomDrawer extends StatelessWidget {
  final Map<String, dynamic>? userData;
  final VoidCallback onLogout;

  const CustomDrawer(
      {super.key, required this.userData, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final String userName = JWTHelper.getUserName(userData);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
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
                  userName,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Configuraciones"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Cerrar Sesión",
                style: TextStyle(color: Colors.red)),
            onTap: () {
              LogoutDialog.show(context, onLogout);
            },
          ),
        ],
      ),
    );
  }
}
