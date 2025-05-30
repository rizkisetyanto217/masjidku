import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DkmStudyScreen extends StatelessWidget {
  const DkmStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> kajianList = [
      {
        "judul": "Rencana Allah yang terbaik",
        "ustadz": "Ustadz Abdullah",
        "tanggal": "4 Maret 2025, Pukul 10.00 WIB",
        "status": "Tersedia pukul 20.00 WIB",
        "statusColor": Colors.orange,
      },
      {
        "judul": "Rencana Allah yang terbaik (2)",
        "ustadz": "Ustadz Abdullah",
        "tanggal": "4 Maret 2025, Pukul 10.00 WIB",
        "status": "Soal dan Materi sudah tersedia",
        "statusColor": Colors.green,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Kajian"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_downward),
                    label: const Text("Terbaru"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.view_agenda_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today_outlined),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: kajianList.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final kajian = kajianList[index];
                  return ListTile(
                    onTap: () {
                      context.go('/kajian/${index + 1}'); // Route detail
                    },
                    title: Text(
                      kajian['judul'],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(kajian['ustadz']),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time_filled, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              kajian['tanggal'],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          kajian['status'],
                          style: TextStyle(
                            fontSize: 13,
                            color: kajian['statusColor'],
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
