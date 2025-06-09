import 'package:flutter/material.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/status_tag_component.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/study_card_component.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> studyData = [
    {
      "title": "Aqidah Bagian ke-3",
      "teacher": "Ustadz Abdullah",
      "date": "4 Maret 2025, Pukul 10.00 WIB - Selesai",
      "tags": [
        StatusTag("Materi & Soal : 90", Color(0xFF4CAF50), Colors.white),
      ],
    },
    {
      "title": "Aqidah Bagian ke-2",
      "teacher": "Ustadz Abdullah",
      "date": "26 Februari 2025, Pukul 10.00 WIB - Selesai",
      "tags": [
        StatusTag("Materi & Soal : 75", Color(0xFF4CAF50), Colors.white),
      ],
    },
    {
      "title": "Aqidah Bagian ke-1",
      "teacher": "Ustadz Abdullah",
      "date": "19 Februari 2025, Pukul 10.00 WIB - Selesai",
      "tags": [
        StatusTag("Materi & Soal : 60", Color(0xFF4CAF50), Colors.white),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soal Latihan"),
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
        itemCount: studyData.length,
        itemBuilder: (context, index) {
          final data = studyData[index];
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
