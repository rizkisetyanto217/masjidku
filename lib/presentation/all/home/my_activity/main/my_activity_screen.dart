import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/button/small_button.dart';
import 'package:masjidku/core/constants/app_color.dart';
import 'package:masjidku/presentation/all/home/home/main/cubit/navigation_cubit.dart';

class MyActivityScreen extends StatelessWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NavigationCubit>().changeTab(4);

    return Scaffold(
      appBar: AppBar(title: const Text("Aktivitas Saya"), elevation: 0),
      body: LayoutBuilder(
        builder:
            (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 16),
                      _buildProfileSection(context),
                      const SizedBox(height: 12),
                      _buildInfoSection(context),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
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
                      const Spacer(),
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
                      // const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 24).copyWith(),

      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Budi Renaldi",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white1,
            ),
          ),
          const Text(
            "Bergabung pada 3 November 2025",
            style: TextStyle(color: AppColors.tertiary),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SmallButton(
                text: "12 Masjid Saya",
                onPressed: () {},
                backgroundColor: Colors.white,
                textColor: AppColors.primary,
              ),
              const SizedBox(width: 8),
              SmallButton(
                text: "Profil Saya",
                onPressed: () => context.go('/my-activity/more'),
                backgroundColor: AppColors.secondary,
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildInfoCard(
                "Donasi",
                "Riwayat donasi yang\ntelah diberikan",
                const Color(0xFFD0F0DA),
                () => GoRouter.of(context).push('/donation/donation-history'),
              ),
              const SizedBox(width: 12),
              _buildInfoCard(
                "Kajian",
                "Riwayat kajian yang\ntelah diikuti",
                const Color(0xFFDFF3D7),
                () => GoRouter.of(context).push('/my-activity/lesson-history'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoCard(
                "Statistik",
                "Data perkembangan\nbelajar",
                const Color(0xFFFFE6C9),
                () => GoRouter.of(context).push('/my-activity/stats'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: Builder(
        builder: (context) {
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
      width: double.infinity, // <-- Tambahkan ini agar lebar full
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
                  final color =
                      tag == "Hadir Langsung"
                          ? Colors.green
                          : tag == "Hadir Online"
                          ? Colors.blue
                          : Colors.teal;
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
