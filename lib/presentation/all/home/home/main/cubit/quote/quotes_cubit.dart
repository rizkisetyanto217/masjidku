import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/core/constants/app_config.dart';
import '../../model/quote_model.dart';
import '../quote/quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl, // ✅ ambil dari AppConfig
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  QuotesCubit() : super(QuotesInitial());

  Future<void> fetchQuotes({int batchNumber = 1}) async {
    emit(QuotesLoading());

    try {
      final response = await _dio.get(
        '/public/quotes', // ✅ gunakan path relatif
        queryParameters: {'batch_number': batchNumber},
      );

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> jsonList = response.data;
        final quotes = jsonList.map((e) => QuoteModel.fromJson(e)).toList();
        emit(QuotesLoaded(quotes));
      } else {
        emit(QuotesError("Format data tidak sesuai"));
      }
    } catch (e) {
      emit(QuotesError("Gagal memuat kutipan: ${e.toString()}"));
    }
  }
}
