import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:masjidku/core/constants/app_config.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/quiz/model/thema_study_quiz_model.dart';
import 'thema_study_quiz_state.dart';

class LectureQuizCubit extends Cubit<LectureQuizState> {
  LectureQuizCubit() : super(LectureQuizInitial());

  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> fetchLectureQuizzes({
    String? lectureId,
    String? lectureSessionId,
  }) async {
    emit(LectureQuizLoading());

    final queryParams = [
      if (lectureId != null) 'lecture_id=$lectureId',
      if (lectureSessionId != null) 'lecture_session_id=$lectureSessionId',
    ].join('&');

    final endpoint =
        '${AppConfig.baseUrl}/public/user-lecture-sessions-quiz/with-detail?$queryParams';
    print('[📡] Fetching quizzes from: $endpoint');

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

      print('[✅] Response status: ${response.statusCode}');
      print('[🧪] Response body keys: ${response.data?.keys}');
      print('[🧪] Raw response: ${response.data}');

      if (response.statusCode != 200) {
        emit(
          LectureQuizError(
            'Gagal memuat kuis (status: ${response.statusCode})',
          ),
        );
        return;
      }

      final data = response.data['data'];
      if (data == null) {
        emit(const LectureQuizLoaded([]));
        return;
      }

      if (data is List) {
        final quizList = _parseQuizzes(data);
        print('[📘] Parsed ${quizList.length} quizzes');
        emit(LectureQuizLoaded(quizList));
      } else {
        emit(
          LectureQuizError(
            'Format data tidak valid, data seharusnya berupa List',
          ),
        );
      }
    } catch (e, st) {
      print('[❌] Exception during fetch: $e');
      print('[❌] Stack trace:\n$st');
      emit(LectureQuizError('Terjadi kesalahan: ${e.toString()}'));
    }
  }

  List<LectureSessionQuizWithUserModel> _parseQuizzes(List<dynamic> data) {
    return data.map((e) {
      final quiz = LectureSessionQuizWithUserModel.fromJson(e);
      print(
        '📘 Quiz: ${quiz.lectureSessionsQuizTitle}, Grade: ${quiz.userLectureSessionsQuizGradeResult}',
      );
      return quiz;
    }).toList();
  }

  Future<String?> _getToken() async {
    const key = 'access_token';
    final token = await _storage.read(key: key);
    print('[🔑] Token: ${token ?? "null"}');
    return token;
  }
}
