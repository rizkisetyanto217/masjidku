class VideoAssetModel {
  final String assetId;
  final String assetTitle;
  final String assetFileUrl;
  final int assetFileType;
  final String type;

  VideoAssetModel({
    required this.assetId,
    required this.assetTitle,
    required this.assetFileUrl,
    required this.assetFileType,
    required this.type,
  });

  factory VideoAssetModel.fromJson(Map<String, dynamic> json) {
    return VideoAssetModel(
      assetId: json['asset_id'],
      assetTitle: json['asset_title'],
      assetFileUrl: json['asset_file_url'],
      assetFileType: json['asset_file_type'],
      type: json['type'],
    );
  }
}
