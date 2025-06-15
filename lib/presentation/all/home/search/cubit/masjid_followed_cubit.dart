import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:masjidku/core/constants/app_config.dart';
import 'package:masjidku/presentation/all/home/search/model/masjid_model.dart';
import 'masjid_followed_state.dart';

class MasjidFollowedCubit extends Cubit<MasjidFollowedState> {
  MasjidFollowedCubit() : super(MasjidFollowedInitial());

  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> fetchFollowedMasjids() async {
    emit(MasjidFollowedLoading());

    final endpoint = '${AppConfig.baseUrl}/api/u/user-follow-masjids/followed';
    print('[📡] Fetching followed masjids from: $endpoint');

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
          MasjidFollowedError(
            'Gagal memuat data (status: ${response.statusCode})',
          ),
        );
        return;
      }

      final responseData = response.data['data'];
      if (responseData == null || responseData is! List) {
        print('[⚠️] Data kosong atau format tidak sesuai.');
        emit(const MasjidFollowedLoaded([]));
        return;
      }

      final masjids = _parseMasjids(responseData);
      emit(MasjidFollowedLoaded(masjids));
    } catch (e, stackTrace) {
      print('[❌] Exception during fetchFollowedMasjids: $e');
      print(stackTrace);
      emit(MasjidFollowedError('Terjadi kesalahan: ${e.toString()}'));
    }
  }

  List<MasjidModel> _parseMasjids(List<dynamic> data) {
    return data.map((e) {
      final item = MasjidModel.fromJson(e);

      print('==== [🧪 MASJID DEBUG] ====');
      print('🏠 Nama   : ${item.masjidName}');
      print('📍 Lokasi : ${item.masjidLocation}');
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
