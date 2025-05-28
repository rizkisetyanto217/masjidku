import 'package:flutter/material.dart';
import 'package:masjidku/presentation/all/home/masjids/details/profile/components/speech_card_component.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final List<Map<String, String>> speechData = [
    {
      "name": "Ustadz Ahmad Fathoni",
      "role": "Ketua DKM Masjid Al-Hikmah",
      "message":
          "Alhamdulillah, dengan adanya aplikasi ini, manajemen masjid menjadi lebih terstruktur dan profesional.",
    },
    {
      "name": "Ibu Nuraini",
      "role": "Bendahara Masjid",
      "message":
          "Kemudahan dalam mencatat donasi membuat saya bisa fokus pada kegiatan sosial di lingkungan sekitar.",
    },
    {
      "name": "H. Kamaludin",
      "role": "Tokoh Masyarakat",
      "message":
          "Saya mendukung inovasi digital seperti ini untuk memajukan kehidupan beragama masyarakat.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Speech Masjid"),
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
        itemCount: speechData.length,
        itemBuilder: (context, index) {
          final data = speechData[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SpeechCard(
              name: data["name"]!,
              role: data["role"]!,
              message: data["message"]!,
            ),
          );
        },
      ),
    );
  }
}
