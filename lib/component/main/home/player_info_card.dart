import 'package:flutter/material.dart';

class PrayerInfoCard extends StatelessWidget {
  final String waktu;
  final String tanggal;
  final String lokasi;

  const PrayerInfoCard({
    super.key,
    required this.waktu,
    required this.tanggal,
    required this.lokasi,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                waktu,
                style: TextStyle(
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tanggal,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(lokasi, style: textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
