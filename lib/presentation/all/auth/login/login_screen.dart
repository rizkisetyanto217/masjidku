import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/presentation/all/auth/login/cubit/login_cubit.dart';
import 'package:masjidku/presentation/all/auth/login/cubit/login_google_cubit.dart';
import 'package:masjidku/presentation/all/auth/login/service/auth_service.dart';
import 'package:masjidku/presentation/all/auth/login/cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit(authService: AuthService())),
        BlocProvider(
          create: (_) => LoginGoogleCubit(authService: AuthService()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.isSuccess) {
                context.go('/');
              } else if (state.error != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error!)));
              }
            },
          ),
          BlocListener<LoginGoogleCubit, LoginState>(
            listener: (context, state) {
              if (state.isSuccess) {
                context.go('/');
              } else if (state.error != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error!)));
              }
            },
          ),
        ],
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, loginState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          const Text(
                            'Selamat Datang!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Masuk untuk mengisi absensi harian Anda',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 32),
                          TextField(
                            onChanged:
                                (value) => context
                                    .read<LoginCubit>()
                                    .updateEmail(value),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            obscureText: true,
                            onChanged:
                                (value) => context
                                    .read<LoginCubit>()
                                    .updatePassword(value),
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed:
                                  (loginState.email.isNotEmpty &&
                                          loginState.password.isNotEmpty &&
                                          !loginState.isLoading)
                                      ? () => context
                                          .read<LoginCubit>()
                                          .loginWithEmail(context)
                                      : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    loginState.email.isNotEmpty &&
                                            loginState.password.isNotEmpty
                                        ? const Color(0xff0E592C)
                                        : Colors.grey,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child:
                                  loginState.isLoading
                                      ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : const Text('Login'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<LoginGoogleCubit, LoginState>(
                            builder: (context, googleState) {
                              return SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed:
                                      googleState.isLoading
                                          ? null
                                          : () => context
                                              .read<LoginGoogleCubit>()
                                              .loginWithGoogle(context),
                                  icon: const Icon(Icons.g_mobiledata),
                                  label:
                                      googleState.isLoading
                                          ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                          : const Text('Login dengan Google'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            text: TextSpan(
                              text: 'Belum punya akun? ',
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Daftar',
                                  style: const TextStyle(
                                    color: Color(0xff0E592C),
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () => context.go('/register'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
