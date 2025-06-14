import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:masjidku/core/constants/app_config.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lecture_sessions_model.dart';
import 'theme_lectures_state.dart';

class ThemeLectureCubit extends Cubit<ThemeLectureState> {
  ThemeLectureCubit() : super(ThemeLectureInitial());

  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> fetchThemeLectures({
    required String masjidId,
    String? lectureId,
  }) async {
    emit(ThemeLectureLoading());

    final queryParams = [
      'masjid_id=$masjidId',
      if (lectureId != null) 'lecture_id=$lectureId',
    ].join('&');

    final endpoint =
        '${AppConfig.baseUrl}/public/user-lecture-sessions/with-progress?$queryParams';
    print('[📡] Fetching from: $endpoint');

    try {
      final token = await _getToken();
      final headers = {
        'User-Agent': 'MasjidkuApp/1.0 Flutter',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(
        endpoint,
        options: Options(headers: headers),
      );

      if (response.statusCode != 200) {
        emit(
          ThemeLectureError(
            'Gagal memuat data (status: ${response.statusCode})',
          ),
        );
        return;
      }

      final responseData = response.data['data'];
      if (responseData == null || responseData is! List) {
        emit(const ThemeLectureLoaded([]));
        return;
      }

      final sessionList = _parseLectureSessions(responseData);
      emit(ThemeLectureLoaded(sessionList));
    } catch (e, stackTrace) {
      print('[❌] Exception during fetch: $e');
      print(stackTrace);
      emit(ThemeLectureError('Terjadi kesalahan: ${e.toString()}'));
    }
  }

  List<MasjidLectureSessionsModel> _parseLectureSessions(List<dynamic> data) {
    return data.map((e) {
      final item = MasjidLectureSessionsModel.fromJson(e);
      print(
        '📘 Sesi: ${item.title}, Pengajar: ${item.teacherName}, Nilai: ${item.userGradeResult}',
      );
      return item;
    }).toList();
  }

  Future<String?> _getToken() async {
    const key = 'access_token';
    final token = await _storage.read(key: key);
    print('[🔑] Token: ${token ?? "null"}');
    return token;
  }
}
