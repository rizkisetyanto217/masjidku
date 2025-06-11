import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:masjidku/presentation/all/masjids/event/main/cubit/masjid_event_sessions_state.dart';
import 'package:masjidku/presentation/all/masjids/event/main/model/masjid_event_sessions_model.dart';

class EventSessionsCubit extends Cubit<EventSessionsState> {
  static const String baseUrl =
      'https://masjidkubackend-production.up.railway.app/';
  final Dio _dio;

  EventSessionsCubit({Dio? dio})
    : _dio = dio ?? Dio(),
      super(EventSessionsInitial()) {
    _configureDio();
  }

  void _configureDio() {
    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, logPrint: print),
    );
  }

  Future<void> loadUpcomingEventSessions({
    required String masjidId,
    String? order,
  }) async {
    emit(EventSessionsLoading());

    try {
      final urlPath = 'public/event-sessions/upcoming/masjid-id/$masjidId';
      final queryParams = {if (order != null) 'order': order.toLowerCase()};

      _logDebug(urlPath, masjidId, order);

      final response = await _dio.get(urlPath, queryParameters: queryParams);

      if (response.statusCode == 200) {
        final dataRaw = response.data['data'];
        final List<dynamic> data = dataRaw is List ? dataRaw : [];

        final events =
            data
                .map(
                  (json) => MasjidEventSessionsModel.fromJson(json as Map<String, dynamic>),
                )
                .toList();

        emit(EventSessionsLoaded(events));
      } else {
        emit(
          EventSessionsError(
            'Failed to load event sessions: ${response.statusCode}',
          ),
        );
      }
    } on DioException catch (e) {
      emit(EventSessionsError(_mapDioError(e)));
    } catch (e) {
      emit(EventSessionsError('Unexpected error: $e'));
    }
  }

  void refresh({required String masjidId, String? order}) {
    loadUpcomingEventSessions(masjidId: masjidId, order: order);
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.receiveTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      default:
        return e.response != null
            ? 'Server error: ${e.response?.statusCode}'
            : 'Unexpected error: ${e.message}';
    }
  }

  void _logDebug(String url, String masjidId, String? order) {
    print('🔍 [EventSessionsCubit] masjidId: $masjidId');
    print('🔍 [EventSessionsCubit] order: $order');
    print('🔍 [EventSessionsCubit] full URL: $url');
  }

  @override
  Future<void> close() {
    _dio.close();
    return super.close();
  }
}
