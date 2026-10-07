import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/login/login_bloc.dart';
import '../router/app_router.dart';
import '../theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  void _handleLogin() {
    context.read<LoginBloc>().add(
      LoginEvent.submitted(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        state.when(
          initial: () {},

          loading: () {},

          success: (user) {
            context.read<AuthBloc>().add(AuthEvent.loggedIn(user));

            context.router.replaceAll([const WorkOrdersRoute()]);
          },
          failure: (_) {},
        );
      },

      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(gradient: AppGradient.grad),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 40),

                      const Icon(
                        Icons.engineering,
                        color: Colors.white,
                        size: 60,
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'Bem-vindo(a)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),

                      const Text(
                        'Para acessar, insira suas credenciais abaixo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),

                      const SizedBox(height: 32),

                      Container(
                        width: 350,
                        constraints: const BoxConstraints(maxWidth: 350),
                        padding: const EdgeInsets.only(
                          top: 40,
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.loginCard,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: 'E-mail',
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  // borderSide: BorderSide(
                                  // color: Color(0xFF838383),
                                  //),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: 'Senha',
                                prefixIcon: const Icon(Icons.lock_outline),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: .all(.circular(15)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: .all(.circular(15)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),

                            if (state is LoginFailure) ...[
                              const SizedBox(height: 12),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  state.message,
                                  style: const TextStyle(
                                    color: AppColors.failed,
                                  ),
                                ),
                              ),
                            ],

                            const SizedBox(height: 24),

                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.loginButton,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: isLoading ? null : _handleLogin,
                                child: isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('ENTRAR', style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                      ),
                              ),
                            ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Inspe',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                              fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 159, 86, 226),
                            letterSpacing: 0.3,
                          ),
                        ),
                         Text(
                          'Campo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 159, 86, 226),
                            letterSpacing: 0.3,
                      ),
                     )
                    ],
                  ),
                ),
                    ]
              ),
            ),
          ),
         )
          )
        );
      },
    );
  }
}
