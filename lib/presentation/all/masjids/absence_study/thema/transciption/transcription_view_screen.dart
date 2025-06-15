import 'package:flutter/material.dart';

class TranscriptViewScreen extends StatelessWidget {
  final String title;
  final String content;

  const TranscriptViewScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(content),
      ),
    );
  }
}
