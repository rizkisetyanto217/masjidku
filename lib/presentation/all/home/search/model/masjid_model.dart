class MasjidModel {
  final String masjidName;
  final String masjidLocation;
  final String masjidImage;
  final String masjidSlug;
  final String? followCreatedAt; // ✅ Optional, hanya muncul jika follow

  MasjidModel({
    required this.masjidName,
    required this.masjidLocation,
    required this.masjidImage,
    required this.masjidSlug,
    this.followCreatedAt,
  });

  factory MasjidModel.fromJson(Map<String, dynamic> json) => MasjidModel(
    masjidName: json['masjid_name'] ?? '',
    masjidLocation: json['masjid_location'] ?? '',
    masjidImage: json['masjid_image_url'] ?? '',
    masjidSlug: json['masjid_slug'] ?? '',
    followCreatedAt: json['follow_created_at'], // bisa null
  );
}
