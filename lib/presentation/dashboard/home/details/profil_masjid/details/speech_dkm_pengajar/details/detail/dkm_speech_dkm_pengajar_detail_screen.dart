import 'package:flutter/material.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class DkmSpeechDkmPengajarDetailScreen extends StatelessWidget {
  const DkmSpeechDkmPengajarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final role = args?['role'] ?? 'Pengurus';
    final speech = args?['speech'] ??
        'Belum ada sambutan untuk $role. Silakan tambahkan sambutan.';

    return Scaffold(
      appBar: AppBar(
        title: Text("Sambutan $role"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.more_vert),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  speech,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            MainButton(
              label: "Edit Sambutan",
              onPressed: () {
                // Arahkan ke halaman edit dengan data lama
                Navigator.pushNamed(
                  context,
                  '/dkm/profil-masjid/speech-dkm-pengajar/detail/edit',
                  arguments: {
                    'role': role,
                    'initialSpeech': speech,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
