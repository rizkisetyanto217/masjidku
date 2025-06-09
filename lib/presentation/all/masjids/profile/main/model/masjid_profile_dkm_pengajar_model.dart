class MasjidProfileTeacherModel {
  final String id;
  final String name;
  final String role;
  final String description;
  final String message;
  final String imageUrl;

  MasjidProfileTeacherModel({
    required this.id,
    required this.name,
    required this.role,
    required this.description,
    required this.message,
    required this.imageUrl,
  });

  factory MasjidProfileTeacherModel.fromJson(Map<String, dynamic> json) {
    return MasjidProfileTeacherModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      description: json['description'] ?? '',
      message: json['message'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
