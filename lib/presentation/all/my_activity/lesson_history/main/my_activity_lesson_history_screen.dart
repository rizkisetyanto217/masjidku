import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/home/calender/calender_kajian_view.dart';
import 'package:masjidku/component/main/home/calender/kajian_card.dart';
import 'package:masjidku/component/main/home/tab_switch_component.dart';

class MyActivityLessonHistoryScreen extends StatefulWidget {
  const MyActivityLessonHistoryScreen({super.key});

  @override
  State<MyActivityLessonHistoryScreen> createState() =>
      _MyActivityLessonHistoryScreenState();
}

class _MyActivityLessonHistoryScreenState
    extends State<MyActivityLessonHistoryScreen> {
  final List<Map<String, dynamic>> historyList = [
    {
      "date": DateTime(2025, 5, 4),
      "tanggal": "Minggu, 4 Mei 2025",
      "judul": "Kajian Akhlak Mulia",
      "ustadz": "Ustadz Ahmad",
      "lokasi": "Masjid Raya Pondok Indah",
      "waktu": "Pukul 09.00 WIB - 11.00 WIB",
      "badges": [
        {"label": "Materi & Soal", "color": Colors.blue},
        {"label": "Hadir Langsung ✅", "color": Colors.green},
      ],
    },
    {
      "date": DateTime(2025, 5, 15),
      "tanggal": "Kamis, 15 Mei 2025",
      "judul": "Keutamaan Dzikir Pagi",
      "ustadz": "Ustadz Salim",
      "lokasi": "Masjid Al-Muhajirin",
      "waktu": "Pukul 07.00 WIB - 08.00 WIB",
      "badges": [
        {"label": "Hadir Langsung ✅", "color": Colors.green},
      ],
    },
    {
      "date": DateTime(2025, 5, 21),
      "tanggal": "Rabu, 21 Mei 2025",
      "judul": "Tafsir Surat Al-Mulk",
      "ustadz": "Ustadz Idris",
      "lokasi": "Masjid Agung Bekasi",
      "waktu": "Pukul 18.00 WIB - Selesai",
      "badges": [
        {"label": "Status Kehadiran", "color": Colors.orange},
      ],
    },
    {
      "date": DateTime(2025, 5, 21),
      "tanggal": "Rabu, 21 Mei 2025",
      "judul": "Tafsir Surat Al-Mulk (2)",
      "ustadz": "Ustadz Idris",
      "lokasi": "Masjid Agung Bekasi",
      "waktu": "Pukul 18.00 WIB - Selesai",
      "badges": [
        {"label": "Status Kehadiran", "color": Colors.orange},
      ],
    },
  ];

  final List<String> tabs = ["Terbaru", "Bulan"];
  String selectedTab = "Terbaru";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kajian Saya"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/my-activity'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TabSwitch(
              tabs: tabs,
              selectedTab: selectedTab,
              onChanged: (val) => setState(() => selectedTab = val),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  selectedTab == "Terbaru"
                      ? _buildHistoryList()
                      : CalendarKajianView(historyList: historyList),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView(
      children:
          historyList.map((item) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['tanggal'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00796B),
                  ),
                ),
                const SizedBox(height: 8),
                KajianCard(item: item),
                const Divider(height: 32),
              ],
            );
          }).toList(),
    );
  }
}
