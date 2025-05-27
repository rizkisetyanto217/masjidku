import 'package:flutter/material.dart';
import 'package:masjidku/presentation/all/auth/register/register_model.dart';
import 'package:masjidku/presentation/all/auth/register/register_service.dart';

class RegisterController extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RegisterService _registerService = RegisterService();

  bool isLoading = false;

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  bool isValidPassword(String password) => password.length >= 6;

  bool isFormValid() {
    return nameController.text.trim().isNotEmpty &&
        isValidEmail(emailController.text.trim()) &&
        isValidPassword(passwordController.text);
  }

  Future<void> register(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!isFormValid()) return;

    isLoading = true;
    notifyListeners();

    try {
      final user = UserModel(name: name, email: email, password: password);
      await _registerService.registerUser(user);

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('✅ Registrasi berhasil')));
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Email sudah digunakan')),
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
