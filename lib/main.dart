import 'package:flutter/material.dart';
import 'package:pasarela_app/utils/theme_helper.dart';
import 'package:pasarela_app/screens/welcome_screen.dart';
import 'package:pasarela_app/screens/settings/settings_screen.dart';
import 'package:pasarela_app/themes/color_theme.dart'; // 🔥 Importamos los temas

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeMode themeMode = await ThemeHelper.getThemeMode();
  runApp(MyApp(themeMode: themeMode));
}

class MyApp extends StatefulWidget {
  final ThemeMode themeMode;

  const MyApp({super.key, required this.themeMode});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themeMode;
  }

  Future<void> _changeTheme(ThemeMode themeMode) async {
    setState(() {
      _themeMode = themeMode;
    });
    await ThemeHelper.saveThemeMode(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Davo Pagos',
      themeMode: _themeMode, 
      theme: lightTheme, 
      darkTheme: darkTheme, 
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/settings': (context) => SettingsScreen(changeTheme: _changeTheme),
      },
    );
  }
}
