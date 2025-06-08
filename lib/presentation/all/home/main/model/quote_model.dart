class QuoteModel {
  final String id;
  final String text;
  final bool isPublished;
  final int displayOrder;
  final DateTime createdAt;

  QuoteModel({
    required this.id,
    required this.text,
    required this.isPublished,
    required this.displayOrder,
    required this.createdAt,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['quote_id'] as String,
      text: json['quote_text'] as String,
      isPublished: json['is_published'] as bool,
      displayOrder: json['display_order'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
