import 'package:flutter/material.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/posting/post_image_item.dart';
import 'package:masjidku/component/main/posting/post_text_item.dart';
import 'package:go_router/go_router.dart';

class MasjidScreen extends StatefulWidget {
  const MasjidScreen({super.key});

  @override
  State<MasjidScreen> createState() => _MasjidScreenState();
}

class _MasjidScreenState extends State<MasjidScreen> {
  bool isFollowing = true;
  int selectedTabIndex = 0;
  int selectedTab = 0;

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
    return Scaffold(
      body: SafeArea(
        child:
            selectedTabIndex == 0
                ? SingleChildScrollView(
                  // ← scroll untuk grid agar tidak menabrak
                  child: Column(
                    children: [
                      _buildHeader(context),
                      const GapBorderSeparator(),
                      const SizedBox(height: 20),
                      _buildTabBar(),
                      const SizedBox(height: 30),
                      _buildTabContent(),
                    ],
                  ),
                )
                : NestedScrollView(
                  headerSliverBuilder:
                      (context, innerBoxIsScrolled) => [
                        SliverToBoxAdapter(child: _buildHeader(context)),
                        SliverToBoxAdapter(
                          child: Container(
                            height: 10,
                            color: const Color.fromARGB(255, 221, 221, 221),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                        SliverToBoxAdapter(child: _buildTabBar()),
                        const SliverToBoxAdapter(child: SizedBox(height: 30)),
                      ],
                  body: _buildTabContent(),
                ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: MainButton(
          label: "Donasi",
          onPressed: () => GoRouter.of(context).push('/masjid/donation'),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          color: Colors.grey[300],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () => context.go('/home'),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 24,
              color: Colors.black54,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text(
                      "Masjid Jami’ At-Taqwa",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  isFollowing
                      ? OutlinedButton(
                        onPressed: () => _showUnfollowDialog(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          side: const BorderSide(color: Color(0xFF006B64)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(0, 32),
                        ),
                        child: const Text(
                          "Mengikuti",
                          style: TextStyle(
                            color: Color(0xFF006B64),
                            fontSize: 14,
                          ),
                        ),
                      )
                      : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isFollowing = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006B64),
                          foregroundColor:
                              Colors.white, // 🔥 ini bikin teks jadi putih
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(0, 32),
                        ),

                        child: const Text(
                          "Ikuti",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Dikelola oleh DKM Masjid untuk ummat muslim",
                style: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E)),
              ),
              const SizedBox(height: 4),
              const Text(
                "Jln. Sawo Besar No.95, Tanah Abang, Jakarta Pusat, DKI Jakarta",
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 4),
              const Text(
                "Bergabung pada April 2025",
                style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Image.asset(
                    "assets/icon/main/WhatsApp.png",
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    "assets/icon/main/Instagram.png",
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    "assets/icon/main/YouTube.png",
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Text(
                    "300 Postingan",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "300 Pengikut",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => selectedTabIndex = 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Menu Utama",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color:
                        selectedTabIndex == 0
                            ? const Color(0xFF006B64)
                            : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                if (selectedTabIndex == 0)
                  const SizedBox(
                    width: 80,
                    height: 2,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFF006B64),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          GestureDetector(
            onTap: () => setState(() => selectedTabIndex = 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Postingan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color:
                        selectedTabIndex == 1
                            ? const Color(0xFF006B64)
                            : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                if (selectedTabIndex == 1)
                  const SizedBox(
                    width: 80,
                    height: 2,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFF006B64),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    if (selectedTabIndex == 0) {
      // Menu Utama
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
          children: [
            _menuItem(
              Icons.info,
              "Informasi",
              onTap: () => context.go('/masjid/information'),
            ),
            _menuItem(
              Icons.receipt_long,
              "Laporan Keuangan",
              onTap: () => context.go('/masjid/financial-report'),
            ),
            _menuItem(
              Icons.people,
              "Absensi & Belajar",
              onTap: () => context.go('/masjid/absence-study'),
            ),
            _menuItem(
              Icons.calendar_month,
              "Agenda",
              onTap: () => context.go('/masjid/agenda'),
            ),
            _menuItem(
              Icons.workspace_premium,
              "Sertifikat",
              onTap: () => context.go("/masjid/certificate"),
            ),
            _menuItem(
              Icons.person,
              "Profil",
              onTap: () => context.go('/masjid/profile'),
            ),
          ],
        ),
      );
    } else {
      final filteredPosts =
          selectedTab == 0
              ? posts
              : posts.where((p) => p['image'] != null).toList();

      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: filteredPosts.length,
          itemBuilder: (context, index) {
            final post = filteredPosts[index];

            return GestureDetector(
              onTap:
                  () => GoRouter.of(
                    context,
                  ).push('/masjid/detail-posting', extra: post),

              child:
                  post['image'] != null
                      ? PostImageItem(post: post)
                      : PostTextItem(post: post),
            );
          },
        ),
      );
    }
  }

  Widget _menuItem(
    IconData icon,
    String label, {
    int badge = 0,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Icon(icon, size: 40, color: Colors.teal),
              if (badge > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$badge',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Future<void> _showUnfollowDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Konfirmasi"),
            content: const Text("Yakin ingin berhenti mengikuti masjid ini?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Ya, Unfollow"),
              ),
            ],
          ),
    );

    if (result == true) {
      setState(() {
        isFollowing = false;
      });
    }
  }
}
