class LectureSessionMaterialAssetModel {
  final String type;
  final String id;
  final String title;
  final String sessionId;
  final DateTime createdAt;

  // Material only
  final String? materialSummary;
  final String? materialTranscriptFull;

  // Asset only
  final String? assetFileUrl;
  final int? assetFileType;

  const LectureSessionMaterialAssetModel({
    required this.type,
    required this.id,
    required this.title,
    required this.sessionId,
    required this.createdAt,
    this.materialSummary,
    this.materialTranscriptFull,
    this.assetFileUrl,
    this.assetFileType,
  });

  factory LectureSessionMaterialAssetModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    return LectureSessionMaterialAssetModel(
      type: type,
      id:
          type == 'material'
              ? json['material_id'] as String
              : json['asset_id'] as String,
      title:
          type == 'material'
              ? json['material_title'] as String
              : json['asset_title'] as String,
      sessionId: json['session_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),

      // only for material
      materialSummary:
          type == 'material' ? json['material_summary'] as String? : null,
      materialTranscriptFull:
          type == 'material'
              ? json['material_transcript_full'] as String?
              : null,

      // only for asset
      assetFileUrl: type == 'asset' ? json['asset_file_url'] as String? : null,
      assetFileType: type == 'asset' ? json['asset_file_type'] as int? : null,
    );
  }
}
