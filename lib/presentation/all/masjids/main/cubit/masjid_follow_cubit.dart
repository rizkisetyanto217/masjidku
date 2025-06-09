import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:masjidku/core/constants/app_config.dart';

part 'masjid_follow_state.dart';

class MasjidFollowCubit extends Cubit<MasjidFollowState> {
  final String masjidId;
  final _storage = const FlutterSecureStorage();

  MasjidFollowCubit({required this.masjidId})
    : super(const MasjidFollowState(isFollowing: false, isLoading: true)) {
    _loadFollowStatus();
  }

  Future<void> _loadFollowStatus() async {
    emit(state.copyWith(isLoading: true));
    try {
      final token = await _storage.read(key: 'access_token');
      final response = await Dio().get(
        '${AppConfig.baseUrl}/api/u/user-follow-masjids/is-following',
        queryParameters: {'masjid_id': masjidId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final isFollowing = response.data['data']['is_following'] as bool;
      print(
        '[MasjidFollowCubit] _loadFollowStatus => isFollowing: $isFollowing',
      );
      emit(state.copyWith(isFollowing: isFollowing, isLoading: false));
    } catch (e) {
      print('❌ [MasjidFollowCubit] Error _loadFollowStatus: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> setFollowApi(bool follow) async {
    emit(state.copyWith(isLoading: true));
    try {
      final token = await _storage.read(key: 'access_token');
      final endpoint = follow ? 'follow' : 'unfollow';
      final method = follow ? Dio().post : Dio().delete;

      final url = '${AppConfig.baseUrl}/api/u/user-follow-masjids/$endpoint';
      await method(
        url,
        data: {'masjid_id': masjidId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('[MasjidFollowCubit] setFollowApi($follow) => Success');
      emit(state.copyWith(isFollowing: follow, isLoading: false));
    } catch (e) {
      print('❌ [MasjidFollowCubit] Error setFollowApi($follow): $e');
      emit(state.copyWith(isLoading: false));
    }
  }
}
