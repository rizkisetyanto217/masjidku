// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_ppkd/core/utils/debug_logger.dart';

// class AppInitializer {
//   static Future<void> initialize() async {
//     DebugLogger.log("🔄 Memulai inisialisasi aplikasi...");

//     await _saveTestData(); // Simpan data dummy
//     await _printSharedPreferencesData(); // Cek data SharedPreferences

//     DebugLogger.log("✅ Inisialisasi selesai!");
//   }

//   static Future<void> _saveTestData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('username', 'John Doe');
//     await prefs.setInt('age', 25);
//     await prefs.setBool('isDarkMode', false);
//     DebugLogger.log("✅ Data tersimpan di SharedPreferences");
//   }

//   static Future<void> _printSharedPreferencesData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final keys = prefs.getKeys();

//     if (keys.isEmpty) {
//       DebugLogger.log("⚠️ SharedPreferences kosong!");
//     } else {
//       for (String key in keys) {
//         DebugLogger.log("✅ Key: $key, Value: ${prefs.get(key)}");
//       }
//     }
//   }
// }
