import 'package:bloc/bloc.dart';

class VideoCubit extends Cubit<String> {
  VideoCubit() : super('');

  void changeVideo(String videoId) => emit(videoId);
}
