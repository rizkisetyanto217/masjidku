// Komponen 4: TemaProgressCard
import 'package:flutter/material.dart';

class TemaProgressCard extends StatelessWidget {
  final String title;
  final int progress;
  final int total;

  const TemaProgressCard({super.key, 
    required this.title,
    required this.progress,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percent = progress / total;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 10,
              color: const Color(0xFF4CAF50),
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "$progress/$total",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
