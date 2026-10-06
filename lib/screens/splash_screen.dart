import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../router/app_router.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (_, current) => current is! AuthUnknown,
      listener: (context, state) {
        final route = state is AuthAuthenticated
            ? const WorkOrdersRoute()
            : const LoginRoute();

        context.router.replace(route);
      }, 
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}