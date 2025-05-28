import 'package:flutter/material.dart';
import 'package:masjidku/presentation/all/home/masjids/details/absence_study/details/components/status_tag_component.dart';
import 'package:masjidku/presentation/all/home/masjids/details/absence_study/details/components/study_card_component.dart';

class DetailThemaStudySummaryScreen extends StatefulWidget {
  const DetailThemaStudySummaryScreen({super.key});

  @override
  State<DetailThemaStudySummaryScreen> createState() =>
      _DetailThemaStudySummaryScreenState();
}

class _DetailThemaStudySummaryScreenState
    extends State<DetailThemaStudySummaryScreen> {
  final List<Map<String, dynamic>> summaryData = [
    {
      "title": "Ringkasan Bab 1 - Keimanan kepada Allah",
      "teacher": "Ustadz Abdullah",
      "date": "19 Februari 2025",
      "tags": [StatusTag("Durasi: 5 menit", Color(0xFFFFA000), Colors.white)],
    },
    {
      "title": "Ringkasan Bab 2 - Rukun Iman",
      "teacher": "Ustadz Abdullah",
      "date": "26 Februari 2025",
      "tags": [StatusTag("Durasi: 4 menit", Color(0xFFFFA000), Colors.white)],
    },
    {
      "title": "Ringkasan Bab 3 - Keimanan kepada Rasul",
      "teacher": "Ustadz Abdullah",
      "date": "4 Maret 2025",
      "tags": [StatusTag("Durasi: 6 menit", Color(0xFFFFA000), Colors.white)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ringkasan Materi"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: summaryData.length,
        itemBuilder: (context, index) {
          final data = summaryData[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: StudyCard(
              title: data['title'],
              teacher: data['teacher'],
              date: data['date'],
              tags: List<StatusTag>.from(data['tags']),
            ),
          );
        },
      ),
    );
  }
}
