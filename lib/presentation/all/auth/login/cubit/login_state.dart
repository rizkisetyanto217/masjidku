import 'package:masjidku/presentation/all/auth/login/model/user_model.dart';

class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final UserModel? user;

  LoginState({
    required this.email,
    required this.password,
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.user,
  });

  factory LoginState.initial() {
    return LoginState(
      email: '',
      password: '',
      isLoading: false,
      isSuccess: false,
      error: null,
      user: null,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccess,
    String? error,
    UserModel? user,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      user: user ?? this.user,
    );
  }
}
