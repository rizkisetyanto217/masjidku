import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/presentation/all/auth/login/cubit/login_state.dart';
import 'package:masjidku/presentation/all/auth/login/service/auth_service.dart';
import 'package:flutter/material.dart';


class LoginGoogleCubit extends Cubit<LoginState> {
  final AuthService authService;
  LoginGoogleCubit({required this.authService}) : super(LoginState.initial());

  Future<void> loginWithGoogle(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      final user = await authService.loginWithGoogle();
      emit(state.copyWith(user: user, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
