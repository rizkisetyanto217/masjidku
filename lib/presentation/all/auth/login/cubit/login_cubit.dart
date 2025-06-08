import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/presentation/all/auth/login/cubit/login_state.dart';
import '../service/auth_service.dart';
import 'package:flutter/material.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService authService;
  LoginCubit({required this.authService}) : super(LoginState.initial());

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> loginWithEmail(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      final user = await authService.loginWithEmail(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(user: user, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
