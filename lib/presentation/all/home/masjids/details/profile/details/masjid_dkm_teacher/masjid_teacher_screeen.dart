import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MasjidTeacherScreeen extends StatelessWidget {
  const MasjidTeacherScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    final pengajar = [
      {
        "nama": "Ustadz Ahmad Faiz",
        "bidang": "Aqidah dan Fiqih",
        "detail": true,
      },
      {"nama": "Ustadzah Siti Nuraini", "bidang": "Tahsin dan Tilawah"},
      {"nama": "Ustadz Zainal Abidin", "bidang": "Akhlak dan Tasawuf"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengajar Masjid"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: pengajar.length,
        separatorBuilder: (_, __) => const Divider(height: 24),
        itemBuilder: (context, index) {
          final item = pengajar[index] as Map<String, dynamic>;
          final hasDetail = item['detail'] == true;

          return ListTile(
            title: Text(
              item['nama']!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(item['bidang']!),
            contentPadding: EdgeInsets.zero,
            trailing: hasDetail ? const Icon(Icons.chevron_right) : null,
            onTap: hasDetail ? () => context.go('/pengajar/detail') : null,
          );
        },
      ),
    );
  }
}