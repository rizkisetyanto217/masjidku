import 'package:flutter/material.dart';
import 'package:masjidku/component/main/home/quict_access_menu.dart';
import 'package:go_router/go_router.dart';

class ExploreHomeScreen extends StatelessWidget {
  const ExploreHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> exploreItems = [
      {
        "icon": Icons.mosque,
        "label": "Masjid Terdekat",
        "route": "/explore/nearby",
      },
      {
        "icon": Icons.people,
        "label": "Komunitas",
        "route": "/explore/community",
      },
      {"icon": Icons.event, "label": "Agenda", "route": "/explore/agenda"},
      {
        "icon": Icons.school,
        "label": "Kajian Ilmiah",
        "route": "/explore/kajian",
      },
      {
        "icon": Icons.video_library,
        "label": "Video Dakwah",
        "route": "/explore/video",
      },
      {
        "icon": Icons.library_books,
        "label": "Artikel Islam",
        "route": "/explore/artikel",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore MasjidKu"),
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
        child: GridView.builder(
          itemCount: exploreItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Ubah dari 4 ke 3 biar lebih longgar
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8, // Lebih tinggi agar muat teks 2 baris
          ),
          itemBuilder: (context, index) {
            final item = exploreItems[index];
            return QuickAccessMenuItem(
              icon: item['icon'],
              label: item['label'],
              route: item['route'],
            );
          },
        ),
      ),
    );
  }
}
