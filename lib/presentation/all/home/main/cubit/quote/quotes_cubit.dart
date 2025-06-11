import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/core/constants/app_config.dart';
import '../../model/quote_model.dart';
import 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  bool _hasFetched = false;

  QuotesCubit() : super(QuotesInitial());

  Future<void> fetchQuotes({int batchNumber = 1}) async {
    if (_hasFetched) {
      print('[QuotesCubit] ⚠️ Sudah pernah fetch, abaikan fetch ulang');
      return;
    }

    print('[QuotesCubit] 📥 Memulai fetch kutipan (batch: $batchNumber)');
    emit(QuotesLoading());
    try {
      final response = await _dio.get(
        '/public/quotes',
        queryParameters: {'batch_number': batchNumber},
      );

      final statusCode = response.statusCode;
      final body = response.data;

      if (statusCode == 200 && body is List) {
        final List<dynamic> jsonList = body;
        final quotes = jsonList.map((e) => QuoteModel.fromJson(e)).toList();
        _hasFetched = true;
        emit(QuotesLoaded(quotes));
      } else {
        emit(QuotesError("Format data tidak sesuai"));
      }
    } catch (e) {
      emit(QuotesError("Gagal memuat kutipan: ${e.toString()}"));
    }
  }
}
