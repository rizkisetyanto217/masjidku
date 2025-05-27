import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button_nav.dart';
import 'package:masjidku/component/main/posting/post_image_item.dart';
import 'package:masjidku/component/main/posting/post_text_item.dart';

// import 'post_image_item.dart';
// import 'post_text_item.dart';

class PostinganScreen extends StatefulWidget {
  const PostinganScreen({super.key});

  @override
  State<PostinganScreen> createState() => _PostinganScreenState();
}

class _PostinganScreenState extends State<PostinganScreen> {
  int selectedTab = 0;
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

  String _getRouteForIndex(int index) {
    switch (index) {
      case 0:
        return '/';
      case 1:
        return '/time-pray';
      case 2:
        return '/posting';
      case 3:
        return '/donasi';
      case 4:
        return '/my-activity';
      default:
        return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredPosts =
        selectedTab == 0
            ? posts
            : posts.where((p) => p['image'] != null).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Postingan")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children:
                  List.generate(tabs.length, (index) {
                        final isSelected = selectedTab == index;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedTab = index),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? const Color(0xFF006B64)
                                        : Colors.transparent,
                                border: Border.all(
                                  color: const Color(0xFF006B64),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                tabs[index],
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                      .expand((widget) => [widget, const SizedBox(width: 8)])
                      .toList()
                    ..removeLast(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                if (post['image'] != null) {
                  return PostImageItem(post: post);
                } else {
                  return PostTextItem(post: post);
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 2, // ← sesuaikan index navbar untuk halaman ini
        onTap: (index) {
          if (index == 2) return; // sudah di halaman ini
          context.go(_getRouteForIndex(index));
        },
      ),
    );
  }
}
