import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const InspecaoCampoApp());
}

class InspecaoCampoApp extends StatelessWidget {
  const InspecaoCampoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InspeCampo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginScreen(),
    );
  }
}