import 'package:equatable/equatable.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lecture_sessions_model.dart';

abstract class ThemeLectureState extends Equatable {
  const ThemeLectureState();

  @override
  List<Object?> get props => [];
}

class ThemeLectureInitial extends ThemeLectureState {}

class ThemeLectureLoading extends ThemeLectureState {}

class ThemeLectureLoaded extends ThemeLectureState {
  final List<MasjidLectureSessionsModel> sessions;
  const ThemeLectureLoaded(this.sessions);

  @override
  List<Object?> get props => [sessions];
}

class ThemeLectureError extends ThemeLectureState {
  final String message;
  const ThemeLectureError(this.message);

  @override
  List<Object?> get props => [message];
}
