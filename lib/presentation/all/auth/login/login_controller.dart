// lib/controllers/login_controller.dart

import 'package:flutter/material.dart';
// import 'package:masjidku/screens/auth/login/login_model.dart';
import 'package:masjidku/presentation/all/auth/login/login_service.dart';

class LoginController {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginController({
    required this.emailController,
    required this.passwordController,
  });

  // Validasi format email
  bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  // Validasi panjang password
  bool isValidPassword(String password) => password.length >= 6;

  bool isFormValid() {
    return isValidEmail(emailController.text.trim()) &&
        isValidPassword(passwordController.text);
  }

  Future<void> login(BuildContext context, Function(bool) setLoading) async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!isValidEmail(email)) {
      _showSnackBar(context, 'Format email tidak valid');
      return;
    }

    if (!isValidPassword(password)) {
      _showSnackBar(context, 'Password minimal 6 karakter');
      return;
    }

    setLoading(true);

    // final user = await AuthService.login(email, password);

    setLoading(false);

    // if (user != null) {
    //   await AuthService.saveLoginStatus();

    //   // Navigator.pushReplacement(
    //   //   context,
    //   //   MaterialPageRoute(
    //   //     builder:
    //   //         (context) => AbsensiScreen(
    //   //           name: user.name,
    //   //           email: user.email,
    //   //           userId: user.id,
    //   //         ),
    //   //   ),
    //   // );
    // } else {
    //   _showSnackBar(context, 'Email atau password salah');
    // }
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
