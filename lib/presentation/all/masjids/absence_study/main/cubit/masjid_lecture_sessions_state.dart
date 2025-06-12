import 'package:equatable/equatable.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lecture_sessions_model.dart';

abstract class MasjidLectureSessionsState extends Equatable {
  const MasjidLectureSessionsState();

  @override
  List<Object?> get props => [];
}

class AbsenceStudyInitial extends MasjidLectureSessionsState {}

class AbsenceStudyLoading extends MasjidLectureSessionsState {}

class AbsenceStudyLoaded extends MasjidLectureSessionsState {
  final List<MasjidLectureSessionsModel> items;

  const AbsenceStudyLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class AbsenceStudyError extends MasjidLectureSessionsState {
  final String message;

  const AbsenceStudyError(this.message);

  @override
  List<Object?> get props => [message];
}
