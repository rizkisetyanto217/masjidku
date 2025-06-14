class LectureSessionQuizWithUserModel {
  final String lectureSessionsQuizId;
  final String lectureSessionsQuizTitle;
  final String lectureSessionsQuizDescription;
  final String lectureSessionsQuizLectureSessionId;
  final DateTime lectureSessionsQuizCreatedAt;

  final String? userLectureSessionsQuizId;
  final double? userLectureSessionsQuizGradeResult;
  final String? userLectureSessionsQuizUserId;
  final DateTime? userLectureSessionsQuizCreatedAt;

  LectureSessionQuizWithUserModel({
    required this.lectureSessionsQuizId,
    required this.lectureSessionsQuizTitle,
    required this.lectureSessionsQuizDescription,
    required this.lectureSessionsQuizLectureSessionId,
    required this.lectureSessionsQuizCreatedAt,
    this.userLectureSessionsQuizId,
    this.userLectureSessionsQuizGradeResult,
    this.userLectureSessionsQuizUserId,
    this.userLectureSessionsQuizCreatedAt,
  });

  factory LectureSessionQuizWithUserModel.fromJson(Map<String, dynamic> json) {
    return LectureSessionQuizWithUserModel(
      lectureSessionsQuizId: json['lecture_sessions_quiz_id'],
      lectureSessionsQuizTitle: json['lecture_sessions_quiz_title'],
      lectureSessionsQuizDescription: json['lecture_sessions_quiz_description'],
      lectureSessionsQuizLectureSessionId:
          json['lecture_sessions_quiz_lecture_session_id'],
      lectureSessionsQuizCreatedAt: DateTime.parse(
        json['lecture_sessions_quiz_created_at'],
      ),

      userLectureSessionsQuizId: json['user_lecture_sessions_quiz_id'],
      userLectureSessionsQuizGradeResult:
          (json['user_lecture_sessions_quiz_grade_result'] as num?)?.toDouble(),
      userLectureSessionsQuizUserId: json['user_lecture_sessions_quiz_user_id'],
      userLectureSessionsQuizCreatedAt:
          json['user_lecture_sessions_quiz_created_at'] != null
              ? DateTime.parse(json['user_lecture_sessions_quiz_created_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lecture_sessions_quiz_id': lectureSessionsQuizId,
      'lecture_sessions_quiz_title': lectureSessionsQuizTitle,
      'lecture_sessions_quiz_description': lectureSessionsQuizDescription,
      'lecture_sessions_quiz_lecture_session_id':
          lectureSessionsQuizLectureSessionId,
      'lecture_sessions_quiz_created_at':
          lectureSessionsQuizCreatedAt.toIso8601String(),
      'user_lecture_sessions_quiz_id': userLectureSessionsQuizId,
      'user_lecture_sessions_quiz_grade_result':
          userLectureSessionsQuizGradeResult,
      'user_lecture_sessions_quiz_user_id': userLectureSessionsQuizUserId,
      'user_lecture_sessions_quiz_created_at':
          userLectureSessionsQuizCreatedAt?.toIso8601String(),
    };
  }
}
