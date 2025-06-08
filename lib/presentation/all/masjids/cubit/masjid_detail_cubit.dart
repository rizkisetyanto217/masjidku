import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/core/constants/app_config.dart';
import 'masjid_detail_state.dart';
import '../model/masjid_detail_profile.dart';

class MasjidDetailCubit extends Cubit<MasjidDetailState> {
  MasjidDetailCubit() : super(MasjidDetailInitial());

  Future<void> fetchMasjidDetail(String slug) async {
    emit(MasjidDetailLoading());
    try {
      final response = await Dio().get(
        '${AppConfig.baseUrl}/public/masjids/$slug',
        options: Options(
          headers: {
            'User-Agent': 'MasjidkuApp/1.0 Flutter', // ✅ biar aman juga
          },
        ),
      );
      final data = response.data['data'];
      final masjid = MasjidDetailModel.fromJson(data); // ✅ penting
      emit(MasjidDetailLoaded(masjid));
    } catch (e) {
      print('❌ Error fetchMasjidDetail: $e');
      emit(MasjidDetailError("Gagal memuat data masjid."));
    }
  }
}
