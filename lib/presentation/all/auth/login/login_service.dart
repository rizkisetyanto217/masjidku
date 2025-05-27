// lib/services/auth_service.dart

// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masjidku/presentation/all/auth/login/login_model.dart';

// import 'package:masjidku/database/database_helper.dart';

class AuthService {
  // Fungsi login user
  // static Future<UserModel?> login(String email, String password) async {
  //   final userMap = await DatabaseHelper.instance.loginUser(email, password);
  //   if (userMap != null) {
  //     return UserModel.fromMap(userMap);
  //   }
  //   return null;
  // }

  // Fungsi untuk set status login di SharedPreferences
  static Future<void> saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('status', 'login');
  }
}
