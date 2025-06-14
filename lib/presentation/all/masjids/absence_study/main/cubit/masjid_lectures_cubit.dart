import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:masjidku/core/constants/app_config.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lectures_model.dart';
import 'masjid_lectures_state.dart';

class MasjidLecturesCubit extends Cubit<MasjidLecturesState> {
  MasjidLecturesCubit() : super(MasjidLecturesInitial());

  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> fetchUserLectures({required String masjidId}) async {
    emit(MasjidLecturesLoading());

    final endpoint =
        '${AppConfig.baseUrl}/public/user-lectures/with-progress?masjid_id=$masjidId';
    print('[📡] Fetching user lectures from: $endpoint');

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
          MasjidLecturesError(
            'Gagal memuat data (status: ${response.statusCode})',
          ),
        );
        return;
      }

      final responseData = response.data['data'];
      if (responseData == null || responseData is! List) {
        print('[⚠️] Data kosong atau format tidak sesuai.');
        emit(const MasjidLecturesLoaded([]));
        return;
      }

      final lectureList = _parseLectures(responseData);
      emit(MasjidLecturesLoaded(lectureList));
    } catch (e, stackTrace) {
      print('[❌] Exception during fetchUserLectures: $e');
      print(stackTrace);
      emit(MasjidLecturesError('Terjadi kesalahan: ${e.toString()}'));
    }
  }

  List<MasjidLectureModel> _parseLectures(List<dynamic> data) {
    return data.map((e) {
      final item = MasjidLectureModel.fromJson(e);

      print('==== [🧪 DEBUG JSON MASUK] ====');
      print('📘 Judul Kajian: ${item.lectureTitle}');
      print('👨‍🏫 Pengajar   : ${item.lectureTeachers?.join(", ") ?? "-"}');
      print(
        '📚 Progress    : ${item.completeTotalLectureSessions}/${item.totalLectureSessions}',
      );
      print('==== [🧪 END DEBUG] ====');

      return item;
    }).toList();
  }

  Future<String?> _getToken() async {
    const key = 'access_token';
    final token = await _storage.read(key: key);
    print('[🔑] Token from secure storage [$key]: ${token ?? "null"}');
    return token;
  }
}
