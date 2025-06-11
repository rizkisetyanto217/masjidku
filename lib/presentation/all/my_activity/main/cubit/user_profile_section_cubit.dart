import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/core/utils/auth_cubit.dart';
import 'user_profile_section_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final Dio _dio = Dio();
  String? _lastToken; // ⬅️ disimpan untuk menghindari fetch ulang

  UserProfileCubit() : super(UserProfileInitial());

  Future<void> fetchUserProfile(String token) async {
    if (_lastToken == token && state is UserProfileLoaded)
      return; // ⬅️ Skip jika token sama

    emit(UserProfileLoading());
    _lastToken = token;

    try {
      final response = await _dio.get(
        'https://masjidkubackend-production.up.railway.app/api/u/users/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        emit(UserProfileLoaded(response.data['data'], token));
      } else {
        emit(UserProfileError('Data user tidak ditemukan'));
      }
    } catch (e) {
      emit(UserProfileError('Gagal memuat data user: $e'));
    }
  }

  void fetchFromAuthIfAvailable(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    final token = authState.token;

    if (authState.isLoggedIn && token != null) {
      fetchUserProfile(token);
    }
  }
}
