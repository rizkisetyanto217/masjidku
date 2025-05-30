import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/home/tab_switch_component.dart';

class DkmPostScreen extends StatefulWidget {
  const DkmPostScreen({super.key});

  @override
  State<DkmPostScreen> createState() => _DkmPostScreenState();
}

class _DkmPostScreenState extends State<DkmPostScreen> {
  String selectedTab = "Semua";
  final List<String> tabs = ["Semua", "Kajian"];

  final List<Map<String, dynamic>> posts = [
    {
      "masjid": "Masjid Al Huda, Ciracas",
      "quote":
          "\"Bersabarlah pada kebaikan maka Allah ta’ala akan mudahkan segalanya\"",
      "date": "3 Dzulhijjah 1445 H / 4 November 2025 M",
      "image": null,
    },
    {
      "masjid": "Masjid At-Taufiq, Kampung Melayu",
      "quote":
          "Pembahasan kitab Aqidah bab iman kepada Allah ta’ala. Kajian insya Allah berlangsung pada Senin, 4 Maret 2025 mendatang.",
      "date": "3 Dzulhijjah 1445 H / 4 November 2025 M",
      "image": "assets/images/sample.jpg",
      "dukungan": 2,
    },
    {
      "masjid": "Masjid At-Taubah, Bandung Barat",
      "quote":
          "\"Qadarullah, Kajian Ustadz Budi dibatalkan karena ada udzur syar’i.\"",
      "date": "3 Dzulhijjah 1445 H / 4 November 2025 M",
      "image": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredPosts =
        selectedTab == "Semua"
            ? posts
            : posts.where((p) => p['image'] != null).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Postingan"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabSwitch(
              tabs: tabs,
              selectedTab: selectedTab,
              onChanged: (label) => setState(() => selectedTab = label),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (_, __) => const Divider(height: 32),
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['masjid'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(post['quote']),
                    const SizedBox(height: 8),
                    if (post['image'] != null)
                      AspectRatio(
                        aspectRatio: 1, // 1:1 seperti feed Instagram
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(post['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 8),
                    Text(post['date'], style: const TextStyle(fontSize: 12)),
                    if (post['dukungan'] != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite, size: 16),
                            label: const Text("Dukung Kajian"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00796B),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${post['dukungan']} orang mendukung",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MainButton(
              label: "Buat Postingan",
              onPressed: () {
                context.go('/dkm/post/create'); // Ganti sesuai rute post baru
              },
            ),
          ),
        ],
      ),
    );
  }
}
