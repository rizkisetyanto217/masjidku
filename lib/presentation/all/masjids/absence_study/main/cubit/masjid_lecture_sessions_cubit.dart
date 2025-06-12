import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:masjidku/core/constants/app_config.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lecture_sessions_model.dart';
import 'masjid_lecture_sessions_state.dart';

class MasjidLectureSessionsCubit extends Cubit<MasjidLectureSessionsState> {
  MasjidLectureSessionsCubit() : super(AbsenceStudyInitial());

  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> fetchAbsenceStudy({required String masjidId}) async {
    emit(AbsenceStudyLoading());

    final endpoint =
        '${AppConfig.baseUrl}/public/user-lecture-sessions/with-progress?masjid_id=$masjidId';
    print('[📡] Fetching absence study data from: $endpoint');

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
        print('[⚠️] Request failed with status: ${response.statusCode}');
        emit(
          AbsenceStudyError(
            'Gagal memuat data (status: ${response.statusCode})',
          ),
        );
        return;
      }

      final responseData = response.data['data'];
      if (responseData == null || responseData is! List) {
        print('[⚠️] Data kosong atau format tidak sesuai.');
        emit(const AbsenceStudyLoaded([]));
        return;
      }

      final sessionList = _parseLectureSessions(responseData);
      emit(AbsenceStudyLoaded(sessionList));
    } catch (e, stackTrace) {
      print('[❌] Exception during fetchAbsenceStudy: $e');
      print(stackTrace);
      emit(AbsenceStudyError('Terjadi kesalahan: ${e.toString()}'));
    }
  }

  List<MasjidLectureSessionsModel> _parseLectureSessions(List<dynamic> data) {
    return data.map((e) {
      final item = MasjidLectureSessionsModel.fromJson(e);

      print('==== [🧪 DEBUG JSON MASUK] ====');
      print('📌 ID         : ${item.id}');
      print('📘 Judul      : ${item.title}');
      print('🧑 Pengajar   : ${item.teacherName}');
      print('⏰ Waktu Mulai: ${item.startTime.toIso8601String()}');
      print('🏠 Lokasi     : ${item.place}');
      print('📊 Nilai      : ${item.userGradeResult}');
      print('🎓 Hadir?     : ${item.userAttendanceStatus}');
      print('==== [🧪 END DEBUG] ====');

      return item;
    }).toList();
  }

  Future<String?> _getToken() async {
    const key = 'access_token'; // Ganti jika key kamu beda
    final token = await _storage.read(key: key);
    print('[🔑] Token from secure storage [$key]: ${token ?? "null"}');
    return token;
  }
}
