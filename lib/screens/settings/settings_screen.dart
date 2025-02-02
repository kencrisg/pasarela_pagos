import 'package:flutter/material.dart';
import 'package:pasarela_app/utils/theme_helper.dart';

class SettingsScreen extends StatefulWidget {
  final Function(ThemeMode) changeTheme;

  const SettingsScreen({super.key, required this.changeTheme});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _selectedTheme = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    ThemeMode themeMode = await ThemeHelper.getThemeMode();
    setState(() {
      _selectedTheme = themeMode;
    });
  }

  void _updateTheme(ThemeMode? themeMode) async {
    if (themeMode == null) return;
    setState(() {
      _selectedTheme = themeMode;
    });
    await ThemeHelper.saveThemeMode(themeMode);
    widget.changeTheme(themeMode); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configuración")),
      body: Column(
        children: [
          const Text(
            'Tema del Sistema',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          RadioListTile<ThemeMode>(
            title: const Text("Modo Claro"),
            value: ThemeMode.light,
            groupValue: _selectedTheme,
            onChanged: _updateTheme,
          ),
          RadioListTile<ThemeMode>(
            title: const Text("Modo Oscuro"),
            value: ThemeMode.dark,
            groupValue: _selectedTheme,
            onChanged: _updateTheme,
          ),
          RadioListTile<ThemeMode>(
            title: const Text("Usar Tema del Sistema"),
            value: ThemeMode.system,
            groupValue: _selectedTheme,
            onChanged: _updateTheme,
          ),
        ],
      ),
    );
  }
}
