class MasjidModel {
  final String masjidName;
  final String masjidLocation;
  final String masjidImage;
  final String masjidSlug; // ✅ Tambahkan slug

  MasjidModel({
    required this.masjidName,
    required this.masjidLocation,
    required this.masjidImage,
    required this.masjidSlug,
  });

  factory MasjidModel.fromJson(Map<String, dynamic> json) => MasjidModel(
        masjidName: json['masjid_name'] ?? '',
        masjidLocation: json['masjid_location'] ?? '',
        masjidImage: json['masjid_image_url'] ?? '', // sesuaikan dgn API kamu
        masjidSlug: json['masjid_slug'] ?? '', // ✅ ambil dari API
      );
}
