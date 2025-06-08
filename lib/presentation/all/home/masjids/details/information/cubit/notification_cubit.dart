import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/core/constants/app_config.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future<void> fetchByMasjidId(String masjidId) async {
    emit(NotificationLoading());

    print("🔄 Memulai fetch notifikasi untuk masjid_id: $masjidId");

    try {
      final url = '${AppConfig.baseUrl}/public/notifications/by-masjid';
      print("📡 POST ke: $url");

      final response = await Dio().post(url, data: {'masjid_id': masjidId});

      final statusCode = response.statusCode;
      final responseData = response.data;

      print("✅ Berhasil mendapatkan response ($statusCode)");
      print("📦 Response data: $responseData");

      final data = responseData['data'];
      if (data is List) {
        emit(NotificationLoaded(List<Map<String, dynamic>>.from(data)));
        print("✅ Emit NotificationLoaded (${data.length} item)");
      } else {
        print("⚠️ Format data tidak sesuai: $data");
        emit(NotificationError('Format data tidak sesuai'));
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final message = e.response?.data;

      print("❌ DioError [$status]: $message");
      emit(NotificationError("Gagal memuat notifikasi ($status)"));
    } catch (e, s) {
      print("❌ Exception umum: $e");
      print("🧵 Stacktrace: $s");
      emit(NotificationError("Terjadi kesalahan tak terduga"));
    }
  }
}
