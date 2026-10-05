import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/work_orders_screen.dart';
import 'screens/history_screen.dart';

import 'blocs/login/login_bloc.dart';
import 'blocs/auth/auth_bloc.dart';

import 'repositories/auth_repository.dart';
import 'services/auth_service.dart';
import 'services/token_storage.dart';
import 'services/user_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final authRepository = AuthRepository(
  authService: AuthService(),
  tokenStorage: TokenStorage(),
  userStorage: UserStorage(),
);

  runApp(
    InspecaoCampoApp(
      authRepository: authRepository,
    ),
  );
}

class InspecaoCampoApp extends StatelessWidget {
  const InspecaoCampoApp({
    super.key,
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authRepository)
            ..add(const AuthEvent.started()),
        ),

        BlocProvider(
          create: (_) => LoginBloc(authRepository),
        ),
      ],
      child: MaterialApp(
        title: 'InspecCampo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/work-orders': (context) => const WorkOrdersScreen(),
          '/history': (context) => const HistoryScreen(),
        },
      ),
    );
  }
}