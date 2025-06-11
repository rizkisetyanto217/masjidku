class MasjidEventModel {
  final String eventId;
  final String eventTitle;
  final String eventSlug;
  final String eventDescription;
  final String eventLocation;
  final String eventMasjidId;
  final DateTime eventCreatedAt;

  MasjidEventModel({
    required this.eventId,
    required this.eventTitle,
    required this.eventSlug,
    required this.eventDescription,
    required this.eventLocation,
    required this.eventMasjidId,
    required this.eventCreatedAt,
  });

  factory MasjidEventModel.fromJson(Map<String, dynamic> json) {
    return MasjidEventModel(
      eventId: json['event_id'] as String,
      eventTitle: json['event_title'] as String,
      eventSlug: json['event_slug'] as String,
      eventDescription: json['event_description'] as String,
      eventLocation: json['event_location'] ?? '',
      eventMasjidId: json['event_masjid_id'] as String,
      eventCreatedAt: DateTime.parse(json['event_created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'event_title': eventTitle,
      'event_slug': eventSlug,
      'event_description': eventDescription,
      'event_location': eventLocation,
      'event_masjid_id': eventMasjidId,
      'event_created_at': eventCreatedAt.toIso8601String(),
    };
  }
}
