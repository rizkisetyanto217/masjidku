import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MasjidDKMScreen extends StatelessWidget {
  const MasjidDKMScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pengurus = [
      {"jabatan": "Kepala", "nama": "Bapak H. Mas'udin", "detail": true},
      {"jabatan": "Wakil Kepala", "nama": "Bapak Muhammad Yassir"},
      {"jabatan": "Sekretaris", "nama": "Bapak H. Taufiq"},
      {"jabatan": "Bendahara", "nama": "Bapak Husain"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengurus"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 8)],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: pengurus.length,
        separatorBuilder: (_, __) => const Divider(height: 24),
        itemBuilder: (context, index) {
          final item = pengurus[index] as Map<String, dynamic>;
          final hasDetail = item['detail'] == true;

          return ListTile(
            title: Text(
              item['jabatan']!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(item['nama']!),
            contentPadding: EdgeInsets.zero,
            trailing: hasDetail ? const Icon(Icons.chevron_right) : null,
            onTap: hasDetail ? () => context.go('/pengurus/detail') : null,
          );
        },
      ),
    );
  }
}