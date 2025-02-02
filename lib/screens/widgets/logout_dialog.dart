import 'package:flutter/material.dart';

class LogoutDialog {
  static Future<void> show(BuildContext context, VoidCallback onConfirmLogout) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirmar Cierre de Sesión"),
          content: const Text("¿Desea cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                onConfirmLogout();
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
