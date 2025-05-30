import 'package:flutter/material.dart';

class KajianCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const KajianCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['judul'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text("Ustadz: ${item['ustadz']}"),
            Text("Lokasi: ${item['lokasi']}"),
            Text("Waktu: ${item['waktu']}"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(
                item['badges'].length,
                (i) => Chip(
                  label: Text(
                    item['badges'][i]['label'],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  backgroundColor: item['badges'][i]['color'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
