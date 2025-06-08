import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class CollaborationHomeScreen extends StatefulWidget {
  const CollaborationHomeScreen({super.key});

  @override
  State<CollaborationHomeScreen> createState() =>
      _CollaborationHomeScreenState();
}

class _CollaborationHomeScreenState extends State<CollaborationHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kerjasama Masjid"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              () => context.go(
                '/home',
              ), // Pastikan route '/home' sesuai router kamu
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Masjidku membuka kesempatan bagi masjid, lembaga pendidikan, maupun komunitas keislaman yang ingin berkolaborasi dalam bentuk dakwah, kajian, publikasi materi, hingga kegiatan sosial. Kami percaya bahwa sinergi antar lembaga adalah kunci memperluas manfaat dan mempererat ukhuwah Islamiyah.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            const Text(
              "Jika Anda memiliki program, ide, atau inisiatif yang dapat dikolaborasikan bersama, silakan hubungi tim kami. Kami terbuka untuk menjalin komunikasi dan membangun kerja sama yang saling menguatkan.",
              style: TextStyle(fontSize: 14),
            ),
            const Spacer(),
            MainButton(
              label: "Hubungi Kami",
              onPressed: () {
                // TODO: Ganti dengan navigasi atau dialog kontak
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Aksi hubungi kami ditekan")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
