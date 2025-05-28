// 📁 lib/screens/detail_kajian_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
// import 'package:masjidku/component/post/post_image_item.dart';
// import 'package:masjidku/component/post/post_text_item.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kajian"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 12)],
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KajianInfoSection(),
              const SizedBox(height: 12),
              const GapBorderSeparator(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "Informasi Kajian",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006B64),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildTabContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 20,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
        children: [
          _menuItem(
            context,
            Icons.info,
            "Informasi",
            onTap: () => GoRouter.of(context).go('/masjid/absence-study/study/information'),
          ),
          _menuItem(
            context,
            Icons.abc,
            "Latihan Soal",
            onTap: () => GoRouter.of(context).go('/masjid/absence-study/study/quiz'),
          ),
          _menuItem(
            context,
            Icons.people,
            "Transkip Materi",
            onTap: () => GoRouter.of(context).go('/masjid/absence-study/study/transcription'),
          ),
          _menuItem(
            context,
            Icons.calendar_month,
            "Ringkasan",
            onTap: () => GoRouter.of(context).go('/masjid/absence-study/study/summary'),
          ),
          _menuItem(
            context,
            Icons.event_note_sharp,
            "Video Rekaman",
            onTap: () => GoRouter.of(context).go('/masjid/absence-study/study/video'),
          ),
          _menuItem(
            context,
            Icons.workspace_premium,
            "Ajukan Pertanyaan",
            onTap: () => GoRouter.of(context).go("/masjid/absence-study/study/question-user"),
          ),
          _menuItem(
            context,
            Icons.person,
            "Tanya Jawab",
            onTap: () => GoRouter.of(context).go('/masjid/absence-study/study/faq'),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String label, {
    int badge = 0,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Icon(icon, size: 40, color: Colors.teal),
              if (badge > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$badge',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class KajianInfoSection extends StatelessWidget {
  const KajianInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Informasi Kajian",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF006B64),
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoItem(
            Icons.book_outlined,
            "Materi : Bab 5 - Wudhu dengan sempurna (Pertemuan ke-5)",
          ),
          _buildInfoItem(
            Icons.person_outline,
            "Pengajar : Ustadz Budi Hariadi",
          ),
          _buildInfoItem(
            Icons.schedule_outlined,
            "Jadwal : Tiap sabtu pukul 20.00 WIB",
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatusBox(
                  "Status Kehadiran:\nTanpa keterangan ❌",
                  const Color(0xFFFFA726),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatusBox(
                  "Materi & Soal:\nSudah dikerjakan ✓\nNilai : 90",
                  const Color(0xFF43A047),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildStatusBox(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
