// Komponen 1: StudyCard
import 'package:flutter/material.dart';
import 'status_tag.dart';

class StudyCard extends StatelessWidget {
  final String title;
  final String teacher;
  final String date;
  final List<StatusTag> tags;

  const StudyCard({super.key, 
    required this.title,
    required this.teacher,
    required this.date,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(teacher, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.circle, size: 8, color: Colors.black),
              const SizedBox(width: 6),
              Text(date, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: tags),
        ],
      ),
    );
  }
}
