import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/core/utils/auth_cubit.dart';

class UpcomingKajianSection extends StatelessWidget {
  const UpcomingKajianSection({super.key});

  @override

  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (!state.isLoggedIn) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info_outline, color: Colors.orange),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Silakan login terlebih dahulu untuk melihat kajian mendatang.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kajian Mendatang",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006B64),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildKajianCard(
                    title: "Rencana Allah yang terbaik",
                    ustadz: "Ustadz Abdullah",
                    lokasi: "Masjid Al Hidayah, Senen, Jakarta Pusat",
                    waktu: "4 Maret 2025, Pukul 10.00 WIB – Selesai",
                    tags: ["Hadir Online", "Materi & Soal Tersedia"],
                  ),
                  const SizedBox(height: 12),
                  _buildKajianCard(
                    title: "Rencana Allah yang terbaik",
                    ustadz: "Ustadz Abdullah",
                    lokasi: "Masjid Al Hidayah, Senen, Jakarta Pusat",
                    waktu: "4 Maret 2025, Pukul 10.00 WIB – Selesai",
                    tags: ["Hadir Langsung"],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MainButton(
                label: "Selengkapnya",
                onPressed: () {
                  context.push("/my-activity/lesson-income");
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKajianCard({
    required String title,
    required String ustadz,
    required String lokasi,
    required String waktu,
    required List<String> tags,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF009688),
            ),
          ),
          const SizedBox(height: 4),
          Text("Ustadz: $ustadz"),
          Text(lokasi),
          Text(waktu),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children:
                tags.map((tag) {
                  final color = switch (tag) {
                    "Hadir Langsung" => Colors.green,
                    "Hadir Online" => Colors.blue,
                    _ => Colors.teal,
                  };
                  return Chip(
                    label: Text(tag),
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(side: BorderSide(color: color)),
                    labelStyle: TextStyle(color: color),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
