// import 'package:shared_preferences/shared_preferences.dart';

// class AuthUtils {
//   static const _tokenKey = "access_token";
//   static const _userIdKey = "user_id";
//   static const _userNameKey = "user_name";
//   static const _userEmailKey = "user_email";

//   // Simpan token dan data user setelah login
//   static Future<void> saveUserSession({
//     required String token,
//     required String userId,
//     required String userName,
//     required String email,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, token);
//     await prefs.setString(_userIdKey, userId);
//     await prefs.setString(_userNameKey, userName);
//     await prefs.setString(_userEmailKey, email);
//   }

//   // Hapus semua data login
//   static Future<void> clearUserSession() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_tokenKey);
//     await prefs.remove(_userIdKey);
//     await prefs.remove(_userNameKey);
//     await prefs.remove(_userEmailKey);
//   }

//   // Cek apakah user sedang login
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey) != null;
//   }

//   // Ambil token
//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey);
//   }

//   // Ambil ID user
//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_userIdKey);
//   }

//   // Ambil nama user
//   static Future<String?> getUserName() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_userNameKey);
//   }

//   // Ambil email user
//   static Future<String?> getUserEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_userEmailKey);
//   }
// }
