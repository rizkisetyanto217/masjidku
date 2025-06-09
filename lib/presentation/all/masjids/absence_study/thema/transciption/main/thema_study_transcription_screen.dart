import 'package:flutter/material.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/status_tag_component.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/study_card_component.dart';

class DetailThemaStudyTranscriptionScreen extends StatefulWidget {
  const DetailThemaStudyTranscriptionScreen({super.key});

  @override
  State<DetailThemaStudyTranscriptionScreen> createState() =>
      _DetailThemaStudyTranscriptionScreenState();
}

class _DetailThemaStudyTranscriptionScreenState
    extends State<DetailThemaStudyTranscriptionScreen> {
  final List<Map<String, dynamic>> transcriptionData = [
    {
      "title": "Materi Bab 1 - Keimanan kepada Allah",
      "teacher": "Ustadz Abdullah",
      "date": "19 Februari 2025, Pukul 10.00 WIB - Selesai",
      "tags": [StatusTag("Durasi: 70 Menit", Color(0xFF00796B), Colors.white)],
    },
    {
      "title": "Materi Bab 2 - Rukun Iman",
      "teacher": "Ustadz Abdullah",
      "date": "26 Februari 2025, Pukul 10.00 WIB - Selesai",
      "tags": [StatusTag("Durasi: 55 Menit", Color(0xFF00796B), Colors.white)],
    },
    {
      "title": "Materi Bab 3 - Keimanan kepada Rasul",
      "teacher": "Ustadz Abdullah",
      "date": "4 Maret 2025, Pukul 10.00 WIB - Selesai",
      "tags": [StatusTag("Durasi: 50 Menit", Color(0xFF00796B), Colors.white)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Materi Lengkap"),
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
        itemCount: transcriptionData.length,
        itemBuilder: (context, index) {
          final data = transcriptionData[index];
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
