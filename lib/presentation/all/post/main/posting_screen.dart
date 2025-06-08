import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/presentation/all/home/main/cubit/navigation_cubit.dart';
import 'package:masjidku/component/main/posting/post_image_item.dart';
import 'package:masjidku/component/main/posting/post_text_item.dart';
import 'package:masjidku/component/main/home/tab_switch_component.dart';

class PostinganScreen extends StatefulWidget {
  const PostinganScreen({super.key});

  @override
  State<PostinganScreen> createState() => _PostinganScreenState();
}

class _PostinganScreenState extends State<PostinganScreen> {
  String selectedTab = "Semua";
  final List<String> tabs = ["Semua", "Motivasi"];

  final List<Map<String, dynamic>> posts = [
    {
      "masjid": "Masjid Al Huda, Ciracas",
      "quote":
          "\"Bersabarlah pada kebaikan maka Allah ta’ala akan mudahkan segalanya\"",
      "date": "3 Dzulhijjah 1445 H / 4 November 2025 M",
      "image": null,
      "category": "Semua",
    },
    {
      "masjid": "Masjid At-Taufiq, Kampung Melayu",
      "quote":
          "Pembahasan kitab Aqidah bab iman kepada Allah ta’ala. Kajian insya Allah berlangsung pada Senin, 4 Maret 2025 mendatang.",
      "date": "3 Dzulhijjah 1445 H / 4 November 2025 M",
      "image": "assets/images/sample.jpg",
      "dukungan": 2,
      "category": "Semua",
    },
    {
      "masjid": "Masjid At-Taubah, Bandung Barat",
      "quote":
          "\"Qadarullah, Kajian Ustadz Budi dibatalkan karena ada udzur syar’i.\"",
      "date": "3 Dzulhijjah 1445 H / 4 November 2025 M",
      "image": null,
      "category": "Semua",
    },
    {
      "author": "Ibu Agus",
      "message": "Semoga Allah ta’ala memudahkan orang-orang mukmin.",
      "category": "Motivasi",
    },
    {
      "author": "Ibu Harianto",
      "message":
          "Semoga Allah ta’ala memudahkan orang yang senantiasa menuntut ilmu.",
      "category": "Motivasi",
    },
  ];

  @override
  void initState() {
    super.initState();
    context.read<NavigationCubit>().changeTab(2);
  }

  List<Map<String, dynamic>> get filteredPosts {
    if (selectedTab == "Semua") {
      return posts.where((p) => p['category'] == 'Semua').toList();
    } else {
      return posts.where((p) => p['category'] == selectedTab).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Postingan")),
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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                if (post['category'] == 'Motivasi') {
                  return _buildMotivasiCard(post);
                }
                return GestureDetector(
                  onTap: () => context.go('/posting/detail', extra: post),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child:
                        post['image'] != null
                            ? PostImageItem(post: post)
                            : PostTextItem(post: post),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivasiCard(Map<String, dynamic> post) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['author'] ?? '-',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(post['message'] ?? ''),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.favorite_border, size: 16),
                SizedBox(width: 4),
                Text("Suka"),
                SizedBox(width: 24),
                Icon(Icons.share, size: 16),
                SizedBox(width: 4),
                Text("Bagikan"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
