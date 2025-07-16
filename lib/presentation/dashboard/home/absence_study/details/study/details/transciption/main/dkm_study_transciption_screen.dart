import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DkmStudyTransciptionScreen extends StatefulWidget {
  const DkmStudyTransciptionScreen({super.key});

  @override
  State<DkmStudyTransciptionScreen> createState() =>
      _DkmStudyTransciptionScreenState();
}

class _DkmStudyTransciptionScreenState
    extends State<DkmStudyTransciptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Materi"),
        leading: const BackButton(),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // --- Status Card
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.error_outline, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Status : Belum dipublikasikan",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Transkrip Konten
              const Text(
                "Dari Umar bin Khattab radhiyallahu ‘anhu, ia berkata: Suatu hari kami duduk bersama Rasulullah ﷺ, lalu datang seorang laki-laki berpakaian sangat putih dan berambut sangat hitam (Jibril). Ia bertanya: “Wahai Muhammad, kabarkan kepadaku tentang iman.” Rasulullah ﷺ menjawab:",
              ),
              const SizedBox(height: 16),
              _buildQuoteParagraph(
                "“Iman adalah engkau beriman kepada Allah, malaikat-malaikat-Nya, "
                "kitab-kitab-Nya, rasul-rasul-Nya, hari akhir, dan engkau beriman "
                "kepada takdir yang baik maupun yang buruk.”",
              ),
              const SizedBox(height: 12),
              const Text(
                "Hadis ini secara eksplisit menyebutkan urutan rukun iman yang menjadi dasar keyakinan umat Islam.",
              ),
              const SizedBox(height: 24),
              _buildQuoteParagraph(
                "“Iman adalah engkau beriman kepada Allah, malaikat-malaikat-Nya, "
                "kitab-kitab-Nya, rasul-rasul-Nya, hari akhir, dan engkau beriman "
                "kepada takdir yang baik maupun yang buruk.”",
              ),
              const SizedBox(height: 12),
              const Text(
                "Hadis ini secara eksplisit menyebutkan urutan rukun iman yang menjadi dasar keyakinan umat Islam.",
              ),
              const SizedBox(height: 100),
            ],
          ),

          // Ganti bagian Stack > Positioned menjadi:
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.go('/dkm/study/study/transcription/edit');
                    },
                    icon: const Icon(Icons.edit, color: Colors.teal),
                    tooltip: 'Edit',
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // TODO: Aksi publikasi
                      },
                      icon: const Icon(Icons.publish),
                      label: const Text("Publikasi Sekarang"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteParagraph(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
      ),
    );
  }
}
