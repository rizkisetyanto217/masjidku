import 'package:flutter/material.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class StudyQuizSummaryScreen extends StatelessWidget {
  const StudyQuizSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // Hide default appbar height
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Donasi section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Hanya dengan Rp. 10.000 ",
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text:
                          "Kontribusi dalam pembuatan satu soal untuk mewujudkan pendidikan islam ",
                    ),
                    const TextSpan(
                      text: "gratis ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text: "bagi seluruh kaum muslimin dan umum.",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            const Text(
              "Alhamdulillah Pembelajaran Selesai",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              "“ Bersyukurlah atas apa yang kita telah dapatkan “",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Nilai Ringkasan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SummaryBox(
                  icon: Icons.assignment,
                  value: "90 %",
                  label: "Penilaian",
                ),
                _SummaryBox(
                  icon: Icons.hourglass_bottom,
                  value: "1",
                  label: "Waktu",
                ),
                _SummaryBox(icon: Icons.stars, value: "20", label: "Poin"),
              ],
            ),

            const Spacer(),

            // Buttons
            Column(
              children: [
                MainButton(
                  label: "Ulasan",
                  backgroundColor: const Color(0xFFE0F7FA),
                  foregroundColor: Colors.teal.shade700,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                MainButton(
                  label: "Lanjut",
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _SummaryBox({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.amber, size: 26),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
