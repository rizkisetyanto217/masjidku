import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/core/constants/app_config.dart';
import '../../model/quote_model.dart';
import 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30), // ⬆️ dinaikkan dari 10
      receiveTimeout: const Duration(seconds: 30), // ⬆️ dinaikkan dari 10
    ),
  );

  QuotesCubit() : super(QuotesInitial());
  Future<void> fetchQuotes({int batchNumber = 1}) async {
    print('[QuotesCubit] 📥 Memulai fetch kutipan (batch: $batchNumber)');
    emit(QuotesLoading());
    try {
      final response = await _dio.get(
        '/public/quotes',
        queryParameters: {'batch_number': batchNumber},
      );

      final statusCode = response.statusCode;
      final body = response.data;
      print('[QuotesCubit] 📦 Response body: $body');

      if (statusCode == 200 && body is List) {
        final List<dynamic> jsonList = body;
        final quotes = jsonList.map((e) => QuoteModel.fromJson(e)).toList();
        print('[QuotesCubit] ✅ Emit QuotesLoaded (${quotes.length} item)');
        emit(QuotesLoaded(quotes));
      } else {
        print('[QuotesCubit] ❌ Format data tidak sesuai');
        emit(QuotesError("Format data tidak sesuai"));
      }
    } catch (e) {
      print('[QuotesCubit] ❌ Gagal memuat kutipan: $e');
      emit(QuotesError("Gagal memuat kutipan: ${e.toString()}"));
    }
  }
}
