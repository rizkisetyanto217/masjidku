class MasjidProfileModel {
  final int id;
  final String story;
  final String visi;
  final String misi;
  final String other;
  final int foundedYear;
  final String masjidId;
  final DateTime createdAt;

  MasjidProfileModel({
    required this.id,
    required this.story,
    required this.visi,
    required this.misi,
    required this.other,
    required this.foundedYear,
    required this.masjidId,
    required this.createdAt,
  });

  factory MasjidProfileModel.fromJson(Map<String, dynamic> json) {
    return MasjidProfileModel(
      id: json['masjid_profile_id'] ?? 0,
      story: json['masjid_profile_story'] ?? '',
      visi: json['masjid_profile_visi'] ?? '',
      misi: json['masjid_profile_misi'] ?? '',
      other: json['masjid_profile_other'] ?? '',
      foundedYear: json['masjid_profile_founded_year'] ?? 0,
      masjidId: json['masjid_profile_masjid_id'] ?? '',
      createdAt: DateTime.parse(json['masjid_profile_created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'masjid_profile_id': id,
      'masjid_profile_story': story,
      'masjid_profile_visi': visi,
      'masjid_profile_misi': misi,
      'masjid_profile_other': other,
      'masjid_profile_founded_year': foundedYear,
      'masjid_profile_masjid_id': masjidId,
      'masjid_profile_created_at': createdAt.toIso8601String(),
    };
  }
}
