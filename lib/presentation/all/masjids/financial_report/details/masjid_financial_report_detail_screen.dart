import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class MasjidFinancialReportDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const MasjidFinancialReportDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Laporan"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "1 jam yang lalu",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(data['deskripsi'], style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 6),
            Text(
              data['jumlah'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Jazakumullah khair kepada para jamaah Masjid Al Mu’minun yang telah menginfakkan hartanya. "
              "Semoga Allah ta’ala balas dengan kebaikan yang lebih besar.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
