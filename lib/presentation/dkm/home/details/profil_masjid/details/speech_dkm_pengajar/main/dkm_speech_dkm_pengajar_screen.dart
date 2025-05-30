import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class DkmSpeechDkmPengajarScreen extends StatelessWidget {
  const DkmSpeechDkmPengajarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {
        'label': 'Ketua DKM',
        'speech': 'Ahlan wa sahlan kepada para penuntut ilmu...',
      },
      {
        'label': 'Ketua Pelaksana',
        'speech': 'Jazakumullah khair kepada muslimin yang ...',
      },
      {
        'label': 'Sekretaris',
        'speech': 'Sebaik-baiknya manusia adalah yang paling ...',
      },
      {
        'label': 'Bendahara',
        'speech': 'Ingatlah setiap kebaikan akan dibalas ...',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sambutan"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 12)],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: data.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: Text(item['label']!),
                  subtitle: Text(
                    item['speech']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    context.go(
                      '/dkm/profil-masjid/speech-dkm-pengajar/detail',
                      extra: {
                        'role': item['label'],
                        'initialSpeech': item['speech'],
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MainButton(
              label: "Tambah Sambutan",
              onPressed: () {
                context.go(
                  '/dkm/profil-masjid/speech-dkm-pengajar/add-speech',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
