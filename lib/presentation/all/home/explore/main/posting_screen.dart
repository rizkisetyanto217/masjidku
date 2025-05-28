import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/presentation/all/home/home/main/cubit/navigation_cubit.dart';
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
  void initState() {
    super.initState();
    context.read<NavigationCubit>().changeTab(2);
  }

  @override
  Widget build(BuildContext context) {
    final filteredPosts =
        selectedTab == "Semua"
            ? posts
            : posts.where((p) => p['image'] != null).toList();

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
}
