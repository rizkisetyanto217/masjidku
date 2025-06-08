import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/core/constants/app_config.dart';
import 'masjid_profile_state.dart';
import '../model/masjid_profile_model.dart';

class MasjidProfileCubit extends Cubit<MasjidProfileState> {
  MasjidProfileCubit() : super(MasjidProfileInitial());

  Future<void> fetchMasjidProfile(String masjidId) async {
    emit(MasjidProfileLoading());

    try {
      final response = await Dio().post(
        '${AppConfig.baseUrl}/public/masjid-profiles/by-masjid',
        data: {'masjid_id': masjidId},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'User-Agent': 'MasjidkuApp/1.0 Flutter', // ✅ Tambahan agar aman
          },
        ),
      );

      final data = response.data;
      final profile = MasjidProfileModel.fromJson(data);
      emit(MasjidProfileLoaded(profile));
    } catch (e, stack) {
      print('❌ Error fetchMasjidProfile: $e');
      print('📌 Stack: $stack');
      emit(MasjidProfileError("Gagal memuat profil masjid."));
    }
  }
}
