import 'package:intl/intl.dart';

class MasjidLectureSessionsModel {
  final String id;
  final String title;
  final String description;
  final String teacherId;
  final String? teacherName;
  final DateTime startTime;
  final DateTime endTime;
  final String place;
  final String lectureId;
  final String masjidId;
  final int capacity;
  final bool isPublic;
  final bool isRegistrationRequired;
  final bool isPaid;
  final int? price;
  final DateTime? paymentDeadline;
  final DateTime createdAt;

  // Data dari user_lecture_sessions (nullable)
  final int? userAttendanceStatus;
  final int? userGradeResult;
  final bool? userIsRegistered;
  final bool? userHasPaid;
  final DateTime? userSessionCreatedAt;

  MasjidLectureSessionsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    this.teacherName,
    required this.startTime,
    required this.endTime,
    required this.place,
    required this.lectureId,
    required this.masjidId,
    required this.capacity,
    required this.isPublic,
    required this.isRegistrationRequired,
    required this.isPaid,
    required this.price,
    required this.paymentDeadline,
    required this.createdAt,
    this.userAttendanceStatus,
    this.userGradeResult,
    this.userIsRegistered,
    this.userHasPaid,
    this.userSessionCreatedAt,
  });

  factory MasjidLectureSessionsModel.fromJson(Map<String, dynamic> json) {
    print('🔍 JSON Keys: ${json.keys}');
    print('==== [🧪 DEBUG JSON MASUK] ====');
    print('📌 ID         : ${json['lecture_session_id']}');
    print('📘 Judul      : ${json['lecture_session_title']}');
    print('🧑 Pengajar   : ${json['lecture_session_teacher_name']}');
    print('⏰ Waktu Mulai: ${json['lecture_session_start_time']}');
    print('🏠 Lokasi     : ${json['lecture_session_place']}');
    print('📊 Nilai      : ${json['user_lecture_session_grade_result']}');
    print('🎓 Hadir?     : ${json['user_lecture_session_attendance_status']}');
    print('==== [🧪 END DEBUG] ====');

    return MasjidLectureSessionsModel(
      id: json['lecture_session_id'] ?? '',
      title: json['lecture_session_title'] ?? '',
      description: json['lecture_session_description'] ?? '',
      teacherId: json['lecture_session_teacher_id'] ?? '',
      teacherName: json['lecture_session_teacher_name']?.toString(),
      startTime:
          json['lecture_session_start_time'] != null
              ? DateTime.tryParse(json['lecture_session_start_time']) ??
                  DateTime.now()
              : DateTime.now(),

      endTime:
          json['lecture_session_end_time'] != null
              ? DateTime.tryParse(json['lecture_session_end_time']) ??
                  DateTime.now()
              : DateTime.now(),

      createdAt:
          json['lecture_session_created_at'] != null
              ? DateTime.tryParse(json['lecture_session_created_at']) ??
                  DateTime.now()
              : DateTime.now(),

      place: json['lecture_session_place'] ?? '',
      lectureId: json['lecture_session_lecture_id'] ?? '',
      masjidId: json['lecture_session_masjid_id'] ?? '',
      capacity: json['lecture_session_capacity'] ?? 0,
      isPublic: json['lecture_session_is_public'] ?? true,
      isRegistrationRequired:
          json['lecture_session_is_registration_required'] ?? false,
      isPaid: json['lecture_session_is_paid'] ?? false,
      price: json['lecture_session_price'],
      paymentDeadline:
          json['lecture_session_payment_deadline'] != null
              ? DateTime.tryParse(json['lecture_session_payment_deadline'])
              : null,
      userAttendanceStatus: json['user_lecture_session_attendance_status'],
      userGradeResult: json['user_lecture_session_grade_result'],
      userIsRegistered: json['user_lecture_session_is_registered'],
      userHasPaid: json['user_lecture_session_has_paid'],
      userSessionCreatedAt:
          json['user_lecture_session_user_session_created_at'] != null
              ? DateTime.tryParse(
                json['user_lecture_session_user_session_created_at'],
              )
              : null,
    );
  }

  String get sessionTimeFormatted {
    final tanggal = DateFormat("d MMMM yyyy", "id_ID").format(startTime);
    final jamMulai = DateFormat("HH.mm").format(startTime);
    final jamSelesai = DateFormat("HH.mm").format(endTime);
    return "$tanggal, Pukul $jamMulai - $jamSelesai WIB";
  }

  String? get attendanceStatusText {
    switch (userAttendanceStatus) {
      case 1:
        return "Hadir Langsung ✅";
      case 2:
        return "Hadir Online 🌐";
      case 0:
        return "Tidak Hadir ❌";
      default:
        return null;
    }
  }

  bool get hasQuestions => true; // Placeholder, bisa diubah tergantung data

  /// Menandakan bahwa peserta sudah membayar tapi belum ikut kuis
  bool get hasPaidButNotTakenQuiz {
    return (userHasPaid ?? false) && userGradeResult == null;
  }

  /// Menandakan bahwa peserta sudah daftar tapi belum bayar
  bool get isRegisteredButNotPaid {
    return (userIsRegistered ?? false) && !(userHasPaid ?? false);
  }

  /// Menandakan bahwa sesi ini sudah berakhir
  bool get isSessionOver {
    return endTime.isBefore(DateTime.now());
  }

  /// Menandakan bahwa peserta sudah ikut dan menyelesaikan
  bool get isCompleted {
    return (userGradeResult != null) && ((userAttendanceStatus ?? -1) != -1);
  }
}
