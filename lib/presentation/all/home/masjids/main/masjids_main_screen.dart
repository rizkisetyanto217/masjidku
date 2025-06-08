// MasjidScreen (refactored)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/posting/post_image_item.dart';
import 'package:masjidku/component/main/posting/post_text_item.dart';
import 'package:masjidku/presentation/all/home/masjids/cubit/masjid_detail_cubit.dart';
import 'package:masjidku/presentation/all/home/masjids/cubit/masjid_detail_state.dart';
import 'package:masjidku/presentation/all/home/masjids/model/masjid_detail_profile.dart';
import 'package:masjidku/presentation/all/home/masjids/widget/masjid_header.dart';

class MasjidScreen extends StatefulWidget {
  final String slug;
  const MasjidScreen({super.key, required this.slug});

  @override
  State<MasjidScreen> createState() => _MasjidScreenState();
}

class _MasjidScreenState extends State<MasjidScreen> {
  MasjidDetailModel? masjidData;
  bool isFollowing = true;
  int selectedTabIndex = 0;
  int selectedTab = 0;

  final List<Map<String, dynamic>> posts = [
    {
      "masjid": "Masjid A",
      "quote": "Contoh kutipan",
      "date": "Hari ini",
      "image": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MasjidDetailCubit, MasjidDetailState>(
          builder: (context, state) {
            if (state is MasjidDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MasjidDetailError) {
              return Center(child: Text(state.message));
            } else if (state is MasjidDetailLoaded) {
              masjidData = state.masjid;
              return _buildContent(masjidData!);
            }
            return const SizedBox();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<MasjidDetailCubit, MasjidDetailState>(
        builder: (context, state) {
          final isReady = state is MasjidDetailLoaded;

          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: MainButton(
              label: "Donasi",
              onPressed:
                  isReady
                      ? () => context.push(
                        '/masjid/${widget.slug}/donation',
                        extra: (state).masjid,
                      )
                      : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(MasjidDetailModel masjid) {
    final header = MasjidHeader(
      name: masjid.name,
      bioShort: masjid.bioShort,
      address: masjid.address,
      joinedAt: masjid.joinedAt,
      isFollowing: isFollowing,
      instagramUrl: masjid.instagramUrl,
      whatsappUrl: masjid.whatsappUrl,
      youtubeUrl: masjid.youtubeUrl,
      masjidSlug: masjid.slug,
      onFollowToggle: () async {
        final result = await _showUnfollowDialog(context);
        if (result != null) {
          setState(() => isFollowing = result);
        }
      },
    );

    return selectedTabIndex == 0
        ? SingleChildScrollView(
          child: Column(
            children: [
              header,
              const GapBorderSeparator(),
              const SizedBox(height: 20),
              _buildTabBar(),
              const SizedBox(height: 30),
              _buildTabContent(masjid),
            ],
          ),
        )
        : NestedScrollView(
          headerSliverBuilder:
              (context, _) => [
                SliverToBoxAdapter(child: header),
                const SliverToBoxAdapter(child: GapBorderSeparator()),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(child: _buildTabBar()),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
          body: _buildTabContent(masjid),
        );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => selectedTabIndex = 0),
            child: _tabBarItem("Menu Utama", selectedTabIndex == 0),
          ),
          const SizedBox(width: 24),
          GestureDetector(
            onTap: () => setState(() => selectedTabIndex = 1),
            child: _tabBarItem("Postingan", selectedTabIndex == 1),
          ),
        ],
      ),
    );
  }

  Widget _tabBarItem(String label, bool isActive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isActive ? const Color(0xFF006B64) : Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        if (isActive)
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
    );
  }

  Widget _buildTabContent(MasjidDetailModel masjid) {
    if (selectedTabIndex == 0) {
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
              onTap: () {
                context.go(
                  '/masjid/${widget.slug}/information',
                  extra: masjidData,
                );
              },
            ),

            _menuItem(
              Icons.receipt_long,
              "Laporan Keuangan",
              onTap:
                  () => context.go('/masjid/${masjid.slug}/financial-report'),
            ),
            _menuItem(
              Icons.people,
              "Absensi & Belajar",
              onTap: () => context.go('/masjid/${masjid.slug}/absence-study'),
            ),
            _menuItem(
              Icons.calendar_month,
              "Jadwal Kajian",
              onTap: () => context.go('/masjid/${masjid.slug}/agenda'),
            ),
            _menuItem(
              Icons.event_note_sharp,
              "Acara",
              onTap: () => context.go('/masjid/${masjid.slug}/event'),
            ),
            _menuItem(
              Icons.workspace_premium,
              "Sertifikat",
              onTap: () => context.go('/masjid/${masjid.slug}/certificate'),
            ),
            _menuItem(
              Icons.person,
              "Profil",
              onTap:
                  () => context.go(
                    '/masjid/${masjid.slug}/profile',
                    extra: masjid,
                  ),
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
              onTap: () => context.push('/masjid/detail-posting', extra: post),
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

  Widget _menuItem(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.teal),
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

  Future<bool?> _showUnfollowDialog(BuildContext context) async {
    return showDialog<bool>(
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
  }
}
