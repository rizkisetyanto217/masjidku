import 'package:flutter/material.dart';

class MasjidsDetailPostingScreen extends StatelessWidget {
  final Map<String, dynamic> post;

  const MasjidsDetailPostingScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Postingan"),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post['image'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(post['image']),
              ),
            const SizedBox(height: 16),
            Text(
              post['masjid'] ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              post['date'] ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(post['quote'] ?? '', style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 16),
            if (post['dukungan'] != null)
              Text("Jumlah dukungan: ${post['dukungan']}"),
          ],
        ),
      ),
    );
  }
}
