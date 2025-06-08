import 'package:flutter/material.dart';

class SpeechCard extends StatelessWidget {
  final String name;
  final String role;
  final String message;

  const SpeechCard({
    super.key,
    required this.name,
    required this.role,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(role, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(message, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
