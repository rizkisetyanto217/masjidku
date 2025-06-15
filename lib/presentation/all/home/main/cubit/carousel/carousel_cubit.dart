import 'package:bloc/bloc.dart';
import 'package:masjidku/presentation/all/home/main/model/caraousel_model.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/core/constants/app_config.dart'; // ✅ pastikan AppConfig ada

part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselState> {
  final Dio _dio = Dio();

  CarouselCubit() : super(CarouselInitial());

  Future<void> fetchCarousels() async {
    emit(CarouselLoading());

    final endpoint = '${AppConfig.baseUrl}/public/carousels';
    print('[📡] Fetching carousels from: $endpoint');

    try {
      final response = await _dio.get(endpoint);
      print("[✅] Status: ${response.statusCode}");

      final data = response.data['data'];
      if (data == null || data is! List) {
        print('[⚠️] Data kosong atau format tidak sesuai.');
        emit(CarouselLoaded([]));
        return;
      }

      final carousels = data.map((e) => CarouselModel.fromJson(e)).toList();
      emit(CarouselLoaded(carousels));
    } catch (e, stackTrace) {
      print('[❌] Error saat fetchCarousels: $e');
      print(stackTrace);
      emit(CarouselError('Gagal memuat data carousel: $e'));
    }
  }
}
