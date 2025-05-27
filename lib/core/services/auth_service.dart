// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_ppkd/core/utils/debug_logger.dart';

// class AuthService {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: 'https://arabiya-syari-fiber-production.up.railway.app',
//       connectTimeout: Duration(seconds: 10),
//       receiveTimeout: Duration(seconds: 10),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     ),
//   );

//   Future<bool> login(String email, String password) async {
//     try {
//       Response response = await _dio.post('/auth/login', data: {
//         'email': email,
//         'password': password,
//       });

//       if (response.statusCode == 200) {
//         String token = response.data['token'];
//         await _saveToken(token);
//         DebugLogger.log("✅ Login berhasil, Token: $token");
//         return true;
//       } else {
//         DebugLogger.log("⚠️ Gagal login: ${response.statusCode}");
//         return false;
//       }
//     } catch (e) {
//       DebugLogger.log("❌ Error login: $e");
//       return false;
//     }
//   }

//   Future<void> _saveToken(String token) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('auth_token', token);
//     DebugLogger.log("🔑 Token disimpan di SharedPreferences");
//   }

//   Future<String?> getToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth_token');
//     DebugLogger.log("🔍 Token didapatkan: $token");
//     return token;
//   }

//   Future<void> logout() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('auth_token');
//     DebugLogger.log("🚪 Token dihapus, pengguna logout.");
//   }
// }
