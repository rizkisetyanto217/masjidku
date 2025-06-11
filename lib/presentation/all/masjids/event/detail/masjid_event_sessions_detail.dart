import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masjidku/presentation/all/masjids/event/main/model/masjid_event_sessions_model.dart';

class MasjidEventSessionDetailScreen extends StatelessWidget {
  final MasjidEventSessionsModel session;

  const MasjidEventSessionDetailScreen({super.key, required this.session});

  String _formatDate(String iso) {
    try {
      return DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(iso));
    } catch (_) {
      return "-";
    }
  }

  String _formatTime(String iso) {
    try {
      return DateFormat('HH:mm').format(DateTime.parse(iso));
    } catch (_) {
      return "-";
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = _formatDate(session.startTime);
    final start = _formatTime(session.startTime);
    final end = _formatTime(session.endTime);

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Acara')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              session.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("📅 $date, $start - $end"),
            const SizedBox(height: 8),
            Text("📍 Lokasi: ${session.location}"),
            const SizedBox(height: 8),
            Text("👥 Kapasitas: ${session.capacity}"),
            const SizedBox(height: 8),
            Text(
              "🔓 ${session.isPublic ? 'Terbuka untuk umum' : 'Acara privat'}",
            ),
            const SizedBox(height: 8),
            Text(
              "📝 ${session.isRegistrationRequired ? 'Butuh registrasi' : 'Tanpa registrasi'}",
            ),
            const SizedBox(height: 16),
            const Text(
              "Deskripsi:",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(session.description),
          ],
        ),
      ),
    );
  }
}
