import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/presentation/all/home/home/main/cubit/navigation_cubit.dart';

class TimePrayScreen extends StatefulWidget {
  const TimePrayScreen({super.key});

  @override
  State<TimePrayScreen> createState() => _TimePrayScreenState();
}

class _TimePrayScreenState extends State<TimePrayScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NavigationCubit>().changeTab(1);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> jadwal = [
      {"nama": "Subuh", "waktu": "04.50 WIB"},
      {"nama": "Dzuhur", "waktu": "12.00 WIB"},
      {"nama": "Ashar", "waktu": "15.10 WIB"},
      {"nama": "Magrib", "waktu": "18.05 WIB"},
      {"nama": "Isya", "waktu": "19.15 WIB"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Waktu Sholat")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006B64),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Hari Ini"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Statistik"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "DKI Jakarta, Jakarta Pusat",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              "Selasa, 5 Dzulhijjah 1442 H | 5 November 2025",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Jadwal Sholat
            ...jadwal.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['nama']!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        item['waktu']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            MainButton(label: "Jadwal Sholat Lengkap", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
