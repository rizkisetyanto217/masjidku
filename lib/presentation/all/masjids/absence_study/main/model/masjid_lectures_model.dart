import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lecture_sessions_model.dart';

class MasjidLectureModel {
  final String lectureId;
  final String lectureTitle;
  final String lectureDescription;
  final bool isRecurring;
  final int recurrenceInterval;
  final String lectureImageUrl;
  final String masjidId;
  final DateTime createdAt;
  final int totalLectureSessions;
  final int? completeTotalLectureSessions; // ✅ progress
  final int? userLectureGradeResult; // ✅ nilai
  final DateTime? userLectureCreatedAt; // ✅ tgl daftar
  final List<Teacher> lectureTeachers;
  final List<MasjidLectureSessionsModel> sessions; // ✅ Tambahkan ini

  MasjidLectureModel({
    required this.lectureId,
    required this.lectureTitle,
    required this.lectureDescription,
    required this.isRecurring,
    required this.recurrenceInterval,
    required this.lectureImageUrl,
    required this.masjidId,
    required this.createdAt,
    required this.totalLectureSessions,
    required this.lectureTeachers,
    required this.sessions, // ✅ Tambahkan ini
    this.completeTotalLectureSessions,
    this.userLectureGradeResult,
    this.userLectureCreatedAt,
  });
  factory MasjidLectureModel.fromJson(Map<String, dynamic> json) {
    return MasjidLectureModel(
      lectureId: json['lecture_id'] ?? "",
      lectureTitle: json['lecture_title'] ?? "-",
      lectureDescription: json['lecture_description'] ?? "-",
      isRecurring: json['lecture_is_recurring'] ?? false,
      recurrenceInterval: json['lecture_recurrence_interval'] ?? 0,
      lectureImageUrl: json['lecture_image_url'] ?? "",
      masjidId: json['lecture_masjid_id'] ?? "",
      createdAt:
          json['lecture_created_at'] != null
              ? DateTime.tryParse(json['lecture_created_at']) ?? DateTime.now()
              : DateTime.now(),
      totalLectureSessions: json['total_lecture_sessions'] ?? 0,
      completeTotalLectureSessions: json['complete_total_lecture_sessions'],
      userLectureGradeResult: json['user_lecture_grade_result'],
      userLectureCreatedAt:
          json['user_lecture_created_at'] != null
              ? DateTime.tryParse(json['user_lecture_created_at'])
              : null,
      lectureTeachers:
          (json['lecture_teachers'] as List?)
              ?.map((e) => Teacher.fromJson(e))
              .toList() ??
          [],
      sessions:
          (json['sessions'] as List?)
              ?.map((e) => MasjidLectureSessionsModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  String get teacherNames {
    return lectureTeachers.map((e) => e.name).join(", ");
  }

  @override
  String toString() {
    return 'MasjidLectureModel(title: $lectureTitle, progress: $completeTotalLectureSessions/$totalLectureSessions)';
  }
}

class Teacher {
  final String id;
  final String name;

  Teacher({required this.id, required this.name});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(id: json['id'] ?? "", name: json['name'] ?? "-");
  }
}
