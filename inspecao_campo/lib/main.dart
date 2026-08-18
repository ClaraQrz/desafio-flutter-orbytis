import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/work_orders_screen.dart';
import 'screens/history_screen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/work-orders': (context) => const WorkOrdersScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}