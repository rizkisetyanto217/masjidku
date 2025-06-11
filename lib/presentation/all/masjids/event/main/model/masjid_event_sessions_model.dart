// File: lib/presentation/all/masjids/event/model/masjid_event_model.dart
class MasjidEventSessionsModel {
  final String id;
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final String location;
  final String imageUrl; // Di Dart, nama properti ini camelCase
  final int capacity;
  final bool isPublic;
  final bool isRegistrationRequired;
  final String status;
  final String createdBy;
  final String createdAt;
  final String updatedAt;
  // Anda mungkin perlu menambahkan properti untuk teacher/speaker jika itu ada di data event_session_event_id atau di objek terpisah.
  // Untuk sementara, saya akan anggap teacher bisa di-derive atau diisi placeholder.

  MasjidEventSessionsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.imageUrl,
    required this.capacity,
    required this.isPublic,
    required this.isRegistrationRequired,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MasjidEventSessionsModel.fromJson(Map<String, dynamic> json) {
    return MasjidEventSessionsModel(
      id: json['event_session_id'] as String,
      title: json['event_session_title'] as String,
      description: json['event_session_description'] as String,
      startTime: json['event_session_start_time'] as String,
      endTime: json['event_session_end_time'] as String,
      location: json['event_session_location'] as String,
      imageUrl: json['event_session_image_url'] as String, // <-- Ini penting!
      capacity: json['event_session_capacity'] as int,
      isPublic: json['event_session_is_public'] as bool,
      isRegistrationRequired:
          json['event_session_is_registration_required'] as bool,
      status: json['event_session_status'] as String,
      createdBy: json['event_session_created_by'] as String,
      createdAt: json['event_session_created_at'] as String,
      updatedAt: json['event_session_updated_at'] as String,
    );
  }
}
