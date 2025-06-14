import 'package:equatable/equatable.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/quiz/model/thema_study_quiz_model.dart';


abstract class LectureQuizState extends Equatable {
  const LectureQuizState();

  @override
  List<Object?> get props => [];
}

class LectureQuizInitial extends LectureQuizState {}

class LectureQuizLoading extends LectureQuizState {}

class LectureQuizLoaded extends LectureQuizState {
  final List<LectureSessionQuizWithUserModel> quizzes;

  const LectureQuizLoaded(this.quizzes);

  @override
  List<Object?> get props => [quizzes];
}

class LectureQuizError extends LectureQuizState {
  final String message;

  const LectureQuizError(this.message);

  @override
  List<Object?> get props => [message];
}
