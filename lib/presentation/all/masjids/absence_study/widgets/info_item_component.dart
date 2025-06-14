import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lectures_model.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black87),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  final MasjidLectureModel lecture;

  const InfoSection({super.key, required this.lecture});

  @override
  Widget build(BuildContext context) {
    final tanggalMulai = DateFormat(
      "d MMMM yyyy",
      "id_ID",
    ).format(lecture.createdAt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Informasi Tema Kajian",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF00796B),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        InfoItem(
          icon: Icons.menu_book_outlined,
          text: "Materi : ${lecture.lectureTitle}",
        ),
        InfoItem(
          icon: Icons.person_outline,
          text: "Pengajar : ${lecture.teacherNames}",
        ),
        InfoItem(
          icon: Icons.schedule,
          text:
              "Jadwal : ${lecture.isRecurring ? "Berulang setiap ${lecture.recurrenceInterval} hari" : "Non-berulang"}",
        ),
        InfoItem(
          icon: Icons.calendar_today_outlined,
          text: "Mulai : ${tanggalMulai}",
        ),
        InfoItem(
          icon: Icons.location_on_outlined,
          text: "Lokasi : -", // ❌ belum tersedia di model kamu
        ),
        const SizedBox(height: 6),
        const Text(
          "Sertifikat belum tersedia", // ❌ Belum ada field `hasCertificate`
          style: TextStyle(color: Colors.orange),
        ),
      ],
    );
  }
}
