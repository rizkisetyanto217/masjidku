import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'masjid_profile_dkm_pengajar_state.dart';
import 'package:masjidku/core/constants/app_config.dart';
import '../model/masjid_profile_dkm_pengajar_model.dart';

class MasjidProfileTeacherCubit extends Cubit<MasjidProfileTeacherState> {
  MasjidProfileTeacherCubit() : super(MasjidProfileTeacherInitial());

  Future<void> fetch(String masjidId) async {
    print(
      "🔄 [MasjidProfileTeacherCubit] Fetching data for masjidId: $masjidId",
    );
    emit(MasjidProfileTeacherLoading());

    try {
      final response = await Dio().post(
        '${AppConfig.baseUrl}/public/masjid-profile-teacher-dkm/by-masjid',
        data: {"masjid_profile_teacher_dkm_masjid_id": masjidId},
      );

      print("✅ [MasjidProfileTeacherCubit] Response received");

      final List data = response.data['data'];
      print("📦 [MasjidProfileTeacherCubit] Total data: ${data.length}");

      final result =
          data.map((e) => MasjidProfileTeacherModel.fromJson(e)).toList();

      for (var item in result) {
        print(
          "🧑 ${item.role} | ${item.name} | hasMessage: ${item.message.isNotEmpty}",
        );
      }

      emit(MasjidProfileTeacherLoaded(result));
    } catch (e, stack) {
      print("❌ [MasjidProfileTeacherCubit] Error: $e");
      print("📛 Stack: $stack");
      emit(MasjidProfileTeacherError("Gagal memuat data profil DKM & Ustadz"));
    }
  }
}
