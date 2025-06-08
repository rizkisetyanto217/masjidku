class MasjidDetailModel {
  final String masjidId;
  final String name;
  final String bioShort;
  final String address;
  final String joinedAt;
  final String instagramUrl;
  final String whatsappUrl;
  final String youtubeUrl;
  final String slug;

  MasjidDetailModel({
    required this.masjidId,
    required this.name,
    required this.bioShort,
    required this.address,
    required this.joinedAt,
    required this.instagramUrl,
    required this.whatsappUrl,
    required this.youtubeUrl,
    required this.slug,
  });

  factory MasjidDetailModel.fromJson(Map<String, dynamic> json) {
    return MasjidDetailModel(
      masjidId: json['masjid_id'] ?? '',
      name: json['masjid_name'] ?? '',
      bioShort: json['masjid_bio_short'] ?? '',
      address: json['masjid_location'] ?? '',
      joinedAt: json['masjid_updated_at'] ?? '',
      instagramUrl: json['masjid_instagram_url'] ?? '',
      whatsappUrl: json['masjid_whatsapp_url'] ?? '',
      youtubeUrl: json['masjid_youtube_url'] ?? '',
      slug: json['masjid_slug'] ?? '',
    );
  }
}
