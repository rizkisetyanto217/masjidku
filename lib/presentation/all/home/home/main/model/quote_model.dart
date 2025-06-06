class QuoteModel {
  final String id;
  final String text;

  QuoteModel({required this.id, required this.text});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['quote_id'].toString(),
      text: json['quote_text'], // ✅ ganti dari quote_content
    );
  }
}
