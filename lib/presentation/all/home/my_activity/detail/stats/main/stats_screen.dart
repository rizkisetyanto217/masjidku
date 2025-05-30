import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final List<Map<String, dynamic>> stats = [
    {
      "icon": Icons.menu_book,
      "value": "100",
      "label": "Menghadiri Kajian\nLangsung",
    },
    {
      "icon": Icons.cast_for_education,
      "value": "1",
      "label": "Mengikuti Kajian\nOnline",
    },
    {
      "icon": Icons.hourglass_bottom,
      "value": "Rp. 100.000",
      "label": "Total Donasi",
    },
    {
      "icon": Icons.mosque_outlined,
      "value": "100",
      "label": "Masjid yang Diikuti",
    },
    {
      "icon": Icons.workspace_premium_outlined,
      "value": "100",
      "label": "Sertifikat Didapatkan",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistik"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/my-activity'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: stats.map((item) => _buildStatCard(item)).toList(),
        ),
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item['icon'], color: Colors.teal, size: 32),
          const SizedBox(height: 12),
          Text(
            item['value'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            item['label'],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
