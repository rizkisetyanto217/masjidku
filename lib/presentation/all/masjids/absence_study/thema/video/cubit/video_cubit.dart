import 'package:flutter_bloc/flutter_bloc.dart';

class VideoCubit extends Cubit<String> {
  VideoCubit() : super(""); // default kosong

  void changeVideo(String videoId) {
    emit(videoId);
  }
}
