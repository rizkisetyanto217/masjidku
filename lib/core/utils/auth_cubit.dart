import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isChecking;
  final String? token;
  final String? userId;
  final String? userName;
  final String? userEmail;

  const AuthState({
    required this.isLoggedIn,
    required this.isChecking,
    this.token,
    this.userId,
    this.userName,
    this.userEmail,
  });

  factory AuthState.checking() {
    debugPrint("[AuthState] State: checking");
    return const AuthState(isLoggedIn: false, isChecking: true);
  }

  factory AuthState.loggedOut() {
    debugPrint("[AuthState] State: loggedOut");
    return const AuthState(isLoggedIn: false, isChecking: false);
  }

  factory AuthState.loggedIn({
    required String token,
    required String userId,
    required String userName,
    String? userEmail,
  }) {
    debugPrint("[AuthState] State: loggedIn => userId: $userId");
    return AuthState(
      isLoggedIn: true,
      isChecking: false,
      token: token,
      userId: userId,
      userName: userName,
      userEmail: userEmail,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  static const _tokenKey = "access_token";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthCubit() : super(AuthState.checking()) {
    debugPrint("[AuthCubit] Initialized. Checking login status...");
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    debugPrint("[AuthCubit] checkLoginStatus() called");
    emit(AuthState.checking());

    final token = await _storage.read(key: _tokenKey);

    if (token != null && token.isNotEmpty) {
      try {
        final decoded = JwtDecoder.decode(token);
        final userId = decoded['id'] ?? '';
        final userName = decoded['user_name'] ?? '';
        final userEmail = decoded['user_email'] ?? '';

        debugPrint("[AuthCubit] JWT decoded => userId: $userId");

        if (userId.toString().isNotEmpty) {
          emit(
            AuthState.loggedIn(
              token: token,
              userId: userId,
              userName: userName,
              userEmail: userEmail,
            ),
          );
          return;
        }
      } catch (e) {
        debugPrint("[AuthCubit] ❌ Error decoding JWT: $e");
      }
    }

    emit(AuthState.loggedOut());
  }

  Future<void> saveUserSession({required String token}) async {
    debugPrint("[AuthCubit] saveUserSession called");

    await _storage.write(key: _tokenKey, value: token);
    checkLoginStatus(); // Ambil ulang dari token dan emit
  }

  Future<void> clearUserSession() async {
    debugPrint("[AuthCubit] clearUserSession called");
    await _storage.delete(key: _tokenKey);
    emit(AuthState.loggedOut());
  }
}
