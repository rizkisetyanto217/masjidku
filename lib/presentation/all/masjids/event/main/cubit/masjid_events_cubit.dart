import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/presentation/all/masjids/event/main/model/masjid_event_model.dart';
import 'masjid_events_state.dart';

class MasjidEventCubit extends Cubit<MasjidEventState> {
  final Dio _dio = Dio();

  MasjidEventCubit() : super(MasjidEventInitial());

  Future<void> fetchEventsByMasjid(String masjidId) async {
    emit(MasjidEventLoading());

    try {
      final response = await _dio.post(
        'https://masjidkubackend-production.up.railway.app/public/events/by-masjid',
        data: {'masjid_id': masjidId},
      );
      if (response.statusCode == 200) {
        final rawData = response.data['data'];

        if (rawData == null || (rawData is List && rawData.isEmpty)) {
          emit(const MasjidEventError("Tidak ada event masjid yang tersedia"));
        } else {
          final List<MasjidEventModel> events =
              (rawData as List)
                  .map((e) => MasjidEventModel.fromJson(e))
                  .toList();

          emit(MasjidEventLoaded(events));
        }
      } else {
        emit(const MasjidEventError("Gagal memuat event masjid"));
      }
    } catch (e) {
      emit(MasjidEventError("Terjadi kesalahan: $e"));
    }
  }
}
