import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:masjidku/presentation/all/auth/login/model/user_model.dart';

class AuthService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late final Dio dio;

  AuthService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://masjidkubackend-production.up.railway.app',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await storage.read(key: 'access_token');
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            try {
              await refreshToken();
              final newToken = await storage.read(key: 'access_token');
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              final cloned = await dio.fetch(e.requestOptions);
              return handler.resolve(cloned);
            } catch (err) {
              return handler.reject(e);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      print('[AUTH] 🔐 Login email: $email');
      final res = await dio.post(
        '/auth/login',
        data: {'identifier': email, 'password': password},
      );

      final data = res.data['data'];
      print('[AUTH] ✅ Response login: $data');

      if (data == null || data['user'] == null) {
        throw Exception("Data user tidak ditemukan");
      }

      await _saveUserSession(data);
      return UserModel.fromJson(data['user']);
    } on DioException catch (e) {
      print('[AUTH] ❌ Error login email: ${e.response?.data}');
      throw Exception(e.response?.data['error'] ?? 'Login gagal');
    }
  }

  Future<UserModel> loginWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    print('[AUTH] 🌐 Login dengan Google...');

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception('Login Google dibatalkan');

    final googleAuth = await googleUser.authentication;
    final idToken = googleAuth.idToken;
    if (idToken == null) throw Exception('ID Token tidak ditemukan');

    try {
      final res = await dio.post(
        '/auth/login-google',
        data: {'id_token': idToken},
      );

      final data = res.data['data'];
      print('[AUTH] ✅ Response Google login: $data');

      if (data == null || data['user'] == null) {
        throw Exception("Data user tidak ditemukan dari Google");
      }

      await _saveUserSession(data);
      return UserModel.fromJson(data['user']);
    } on DioException catch (e) {
      print('[AUTH] ❌ Error login Google: ${e.response?.data}');
      throw Exception(e.response?.data['error'] ?? 'Login Google gagal');
    }
  }

  Future<void> refreshToken() async {
    try {
      final token = await storage.read(key: 'refresh_token');
      if (token == null) throw Exception('Refresh token tidak ditemukan');

      print('[AUTH] 🔄 Refresh token...');
      final res = await dio.post(
        '/auth/refresh-token',
        data: {'refresh_token': token},
      );

      final data = res.data['data'];
      await storage.write(key: 'access_token', value: data['access_token']);
      await storage.write(
        key: 'refresh_token',
        value: data['refresh_token_debug'],
      );
      print('[AUTH] 🔄 Token diperbarui');
    } on DioException catch (e) {
      print('[AUTH] ❌ Error refresh token: ${e.response?.data}');
      throw Exception(e.response?.data['error'] ?? 'Gagal refresh token');
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      final token = await storage.read(key: 'access_token');
      if (token != null) {
        await dio.post(
          '${dio.options.baseUrl}/api/auth/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        print('[AUTH] Logout API sukses');
      }

      await storage.deleteAll();
      print('[AUTH] Semua token dan data login dihapus (logout)');

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Berhasil logout')));
        await Future.delayed(const Duration(milliseconds: 400));
      }
    } catch (e) {
      print('[AUTH] Gagal logout: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Logout gagal: $e')));
      }
      rethrow;
    }
  }

  Future<void> _saveUserSession(Map<String, dynamic> data) async {
    await storage.write(key: 'access_token', value: data['access_token']);
    await storage.write(
      key: 'refresh_token',
      value: data['refresh_token_debug'],
    );

    final user = data['user'];
    if (user != null) {
      await storage.write(key: 'user_id', value: user['user_id']);
      await storage.write(key: 'user_name', value: user['user_name']);
      await storage.write(key: 'user_email', value: user['user_email']);
      print('[AUTH] 🗝️ User data disimpan ke storage');
    } else {
      print('[AUTH] ⚠️ Tidak ada user data untuk disimpan');
    }
  }
}
