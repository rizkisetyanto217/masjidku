import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MasjidFinancialReportScreen extends StatelessWidget {
  const MasjidFinancialReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final laporan = [
      {
        "judul": "Donasi Januari 2025",
        "deskripsi": "Alhamdulillah, Donasi sudah terkumpul sebesar",
        "jumlah": "Rp. 1.800.000",
        "tanggal": "3 Dzulhijjah 1445 H / 4 November 2025 M",
      },
      {
        "judul": "Donasi Januari 2025",
        "deskripsi": "Alhamdulillah, Donasi sudah terkumpul sebesar",
        "jumlah": "Rp. 1.800.000",
        "tanggal": "3 Dzulhijjah 1445 H / 4 November 2025 M",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Keuangan"),
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
        itemCount: laporan.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = laporan[index];

          return GestureDetector(
            onTap:
                () => context.go(
                  '/masjid/financial-report/detail',
                  extra: item, // mengirim data laporan sebagai extra
                ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['judul']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14),
                      children: [
                        TextSpan(text: item['deskripsi']),
                        TextSpan(
                          text: ' ${item['jumlah']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF00796B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['tanggal']!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
