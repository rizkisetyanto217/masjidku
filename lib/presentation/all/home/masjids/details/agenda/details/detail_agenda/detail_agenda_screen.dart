import 'package:flutter/material.dart';

class DetailAgendaScreen extends StatelessWidget {
  final Map<String, String> data;

  const DetailAgendaScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Agenda"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar agenda (jika ada)
            if (data['image'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(data['image']!),
              ),

            const SizedBox(height: 16),

            // Informasi Kajian
            Text(
              "Informasi Kajian",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 12),
            _infoRow(Icons.menu_book, "Materi : ${data['subtitle'] ?? '-'}"),
            const SizedBox(height: 8),
            _infoRow(Icons.person, "Pengajar : ${data['ustadz'] ?? '-'}"),
            const SizedBox(height: 8),
            _infoRow(Icons.access_time, "Jadwal : ${data['waktu'] ?? '-'}"),
            const SizedBox(height: 8),
            _infoRow(Icons.location_city, "Tempat : Masjid Jami’ At-Taqwa"),

            const SizedBox(height: 24),

            // Keterangan
            Text(
              "Keterangan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Materi kajian akan membahas bab 5 dari kitab Matan Abu Syuja’ yaitu “Wudhu dengan sempurna”.",
            ),
            const SizedBox(height: 8),
            const Text(
              "Dari Kajian ini diharapkan peserta dapat memahami materi Wudhu dengan sempurna dan mampu menerapkan dalam kehidupan sehari-hari.",
            ),
            const SizedBox(height: 8),
            const Text(
              "Semoga Allah ta’ala memudahkan kita untuk menuntut ilmu sebagai bentuk jalan menuju surga-Nya. Aamiin.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
