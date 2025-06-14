import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/study/main/model/lecture_session_material_asset_model.dart';
import 'material_asset_state.dart';

class LectureSessionMaterialAssetCubit
    extends Cubit<LectureSessionMaterialAssetState> {
  LectureSessionMaterialAssetCubit()
    : super(LectureSessionMaterialAssetInitial());

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://masjidkubackend-production.up.railway.app',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<void> fetchByLectureId(String lectureId) async {
    emit(LectureSessionMaterialAssetLoading());

    try {
      print('[DEBUG] Fetching lecture content for ID: $lectureId');

      final response = await _dio.get(
        '/public/lecture-sessions-content/by-lecture',
        queryParameters: {'lecture_id': lectureId},
      );

      final responseData = response.data;
      print('[DEBUG] Response type: ${responseData.runtimeType}');
      print('[DEBUG] Full response: $responseData');

      // Validasi struktur response
      if (responseData is! Map<String, dynamic>) {
        print(
          '[ERROR] Expected Map<String, dynamic> but got: ${responseData.runtimeType}',
        );
        emit(const LectureSessionMaterialAssetLoaded([]));
        return;
      }

      final raw = responseData['data'];
      if (raw is! List) {
        print('[ERROR] Expected List in ["data"] but got: ${raw.runtimeType}');
        emit(const LectureSessionMaterialAssetLoaded([]));
        return;
      }

      print('[DEBUG] Data contains ${raw.length} items');

      final List<LectureSessionMaterialAssetModel> parsedList = [];

      for (final item in raw) {
        print('[DEBUG] Item type: ${item.runtimeType}');
        if (item is Map<String, dynamic>) {
          try {
            final parsed = LectureSessionMaterialAssetModel.fromJson(item);
            parsedList.add(parsed);
          } catch (e) {
            print('[PARSE ERROR] Failed to parse item: $e');
          }
        } else {
          print('[WARNING] Skipping invalid item: $item');
        }
      }

      print('[DEBUG] Successfully parsed ${parsedList.length} items');
      emit(LectureSessionMaterialAssetLoaded(parsedList));
    } on DioException catch (e) {
      final msg =
          e.response?.data?['message'] ??
          'Gagal memuat konten kajian: ${e.message}';
      print('[DIO ERROR] $msg');
      emit(LectureSessionMaterialAssetError(msg));
    } catch (e, stack) {
      print('[UNCAUGHT ERROR] $e');
      print('[STACKTRACE] $stack');
      emit(LectureSessionMaterialAssetError('Terjadi kesalahan: $e'));
    }
  }
}
