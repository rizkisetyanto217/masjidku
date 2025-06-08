import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/core/constants/app_config.dart';
import 'package:masjidku/presentation/all/home/search/model/masjid_model.dart';
import 'package:masjidku/presentation/all/home/search/cubit/masjid_state.dart';
import 'package:dio/dio.dart';

class MasjidCubit extends Cubit<MasjidState> {
  MasjidCubit() : super(MasjidInitial());

  Future<void> fetchMasjids() async {
    emit(MasjidLoading());
    try {
      final response = await Dio().get('${AppConfig.baseUrl}/public/masjids');

      final List data = response.data['data']; // ✅ field 'data'
      final masjids = data.map((json) => MasjidModel.fromJson(json)).toList();
      emit(MasjidLoaded(masjids));
    } catch (e) {
      print('❌ Error: $e');
      emit(MasjidError('Gagal mengambil data masjid.'));
    }
  }
}
