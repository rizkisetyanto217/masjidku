import 'package:flutter/material.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/status_tag_component.dart';

class StudyCard extends StatelessWidget {
  final String title;
  final String teacher;
  final String date;
  final List<StatusTag> tags;
  final VoidCallback? onTap; // tambahkan ini

  const StudyCard({
    super.key,
    required this.title,
    required this.teacher,
    required this.date,
    required this.tags,
    this.onTap, // dan ini
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // wrapper untuk detect klik
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDDDDDD)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(teacher, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.circle, size: 8, color: Colors.black),
                const SizedBox(width: 6),
                Text(date, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(spacing: 8, runSpacing: 8, children: tags),
          ],
        ),
      ),
    );
  }
}
