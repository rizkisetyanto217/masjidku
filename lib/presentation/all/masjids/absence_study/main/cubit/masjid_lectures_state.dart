import 'package:equatable/equatable.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lectures_model.dart';

abstract class MasjidLecturesState extends Equatable {
  const MasjidLecturesState();

  @override
  List<Object?> get props => [];
}

class MasjidLecturesInitial extends MasjidLecturesState {}

class MasjidLecturesLoading extends MasjidLecturesState {}

class MasjidLecturesLoaded extends MasjidLecturesState {
  final List<MasjidLectureModel> lectures;

  const MasjidLecturesLoaded(this.lectures);

  @override
  List<Object?> get props => [lectures];
}

class MasjidLecturesError extends MasjidLecturesState {
  final String message;

  const MasjidLecturesError(this.message);

  @override
  List<Object?> get props => [message];
}
