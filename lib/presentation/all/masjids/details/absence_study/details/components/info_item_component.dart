// file: info_item_component.dart

import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoItem({required this.icon, required this.text});

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
  const InfoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Informasi Tema Kajian",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF00796B),
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        InfoItem(
          icon: Icons.menu_book_outlined,
          text: "Materi : Kitab Fiqh Syafi’i Matan Abu Syuja’",
        ),
        InfoItem(
          icon: Icons.person_outline,
          text: "Pengajar : Ustadz Budi Hariadi",
        ),
        InfoItem(
          icon: Icons.schedule,
          text: "Jadwal : Tiap sabtu pukul 20.00 WIB",
        ),
        InfoItem(
          icon: Icons.calendar_today_outlined,
          text: "Mulai : 24 Mei 2024 - Sekarang",
        ),
        InfoItem(
          icon: Icons.location_on_outlined,
          text: "Lokasi : Masjid At–Taqwa, Ciracas",
        ),
        SizedBox(height: 6),
        Text(
          "Sertifikat belum tersedia",
          style: TextStyle(color: Colors.orange),
        ),
      ],
    );
  }
}
