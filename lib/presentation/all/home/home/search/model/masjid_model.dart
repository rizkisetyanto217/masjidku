class MasjidModel {
  final String masjidName;
  final String masjidLocation;
  final String masjidImage;

  MasjidModel({
    required this.masjidName,
    required this.masjidLocation,
    required this.masjidImage,
  });

  factory MasjidModel.fromJson(Map<String, dynamic> json) => MasjidModel(
        masjidName: json['masjid_name'] ?? '',
        masjidLocation: json['masjid_location'] ?? '',
        masjidImage: json['masjid_image'] ?? '',
      );
}