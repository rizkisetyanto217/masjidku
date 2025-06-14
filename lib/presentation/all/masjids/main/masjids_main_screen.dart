import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/posting/post_image_item.dart';
import 'package:masjidku/component/main/posting/post_text_item.dart';
import 'package:masjidku/core/utils/auth_cubit.dart';
import 'package:masjidku/presentation/all/donation/details/search_masjid/cubit/selected_masjid_cubit.dart';
import 'package:masjidku/presentation/all/masjids/main/cubit/masjid_detail_cubit.dart';
import 'package:masjidku/presentation/all/masjids/main/cubit/masjid_detail_state.dart';
import 'package:masjidku/presentation/all/masjids/main/cubit/masjid_follow_cubit.dart';
import 'package:masjidku/presentation/all/masjids/main/model/masjid_detail_profile.dart';
import 'package:masjidku/presentation/all/masjids/main/widget/masjid_header.dart';
import 'package:masjidku/presentation/all/masjids/event/main/cubit/masjid_event_sessions_cubit.dart';

class MasjidScreen extends StatelessWidget {
  final String slug;
  final MasjidDetailModel? initialMasjid;

  const MasjidScreen({super.key, required this.slug, this.initialMasjid});

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
              final masjid = state.masjid;
              return Builder(
                builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<SelectedMasjidCubit>(
                        create: (_) => SelectedMasjidCubit(),
                      ),
                      BlocProvider<MasjidFollowCubit>(
                        create:
                            (_) => MasjidFollowCubit(masjidId: masjid.masjidId),
                      ),
                      BlocProvider<EventSessionsCubit>(
                        create:
                            (_) =>
                                EventSessionsCubit()..loadUpcomingEventSessions(
                                  masjidId: masjid.masjidId,
                                  order: "terbaru",
                                ),
                      ),
                    ],
                    child: _MasjidContent(slug: slug, masjid: masjid),
                  );
                },
              );
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
                        '/masjid/$slug/donation',
                        extra: (state).masjid,
                      )
                      : null,
            ),
          );
        },
      ),
    );
  }
}

class _MasjidContent extends StatefulWidget {
  final MasjidDetailModel masjid;
  final String slug;
  const _MasjidContent({required this.masjid, required this.slug});

  @override
  State<_MasjidContent> createState() => _MasjidContentState();
}

class _MasjidContentState extends State<_MasjidContent> {
  int selectedTabIndex = 0;

  final List<Map<String, dynamic>> posts = [
    {
      "masjid": "Masjid A",
      "quote": "Contoh kutipan",
      "date": "Hari ini",
      "image": null,
    },
  ];

  @override
  void dispose() {
    context.read<SelectedMasjidCubit>().clearMasjid();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState.isChecking) {
          return const Center(child: CircularProgressIndicator());
        }

        final isLoggedIn = authState.isLoggedIn;

        return SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<MasjidFollowCubit, MasjidFollowState>(
                builder: (context, followState) {
                  if (followState.isLoading) {
                    return const CircularProgressIndicator();
                  }

                  final isFollowing = followState.isFollowing;

                  return MasjidHeader(
                    name: widget.masjid.name,
                    bioShort: widget.masjid.bioShort,
                    address: widget.masjid.address,
                    joinedAt: widget.masjid.joinedAt,
                    isFollowing: isFollowing,
                    instagramUrl: widget.masjid.instagramUrl,
                    whatsappUrl: widget.masjid.whatsappUrl,
                    youtubeUrl: widget.masjid.youtubeUrl,
                    masjidSlug: widget.masjid.slug,
                    onFollowToggle: () async {
                      if (!isLoggedIn) {
                        _showLoginPrompt(context);
                        return;
                      }

                      final followCubit = context.read<MasjidFollowCubit>();
                      final currentFollowing = followCubit.state.isFollowing;

                      bool? result = true;
                      if (currentFollowing) {
                        result = await _showUnfollowDialog(context);
                      }

                      if (result == true || !currentFollowing) {
                        final newStatus = !currentFollowing;
                        await followCubit.setFollowApi(newStatus);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              newStatus
                                  ? "Mengikuti masjid."
                                  : "Berhenti mengikuti masjid.",
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              const GapBorderSeparator(),
              const SizedBox(height: 12),
              Text(
                "Status login: ${isLoggedIn ? '✅ Sudah Login' : '❌ Belum Login'}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              _buildTabBar(),
              const SizedBox(height: 20),
              _buildTabContent(widget.masjid),
            ],
          ),
        );
      },
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
              onTap:
                  () => context.push(
                    '/masjid/${widget.slug}/information',
                    extra: masjid,
                  ),
            ),
            _menuItem(
              Icons.receipt_long,
              "Laporan Keuangan",
              onTap:
                  () => context.push('/masjid/${masjid.slug}/financial-report'),
            ),
            _menuItem(
              Icons.people,
              "Absensi & Belajar",
              onTap:
                  () => context.push(
                    '/masjid/${masjid.slug}/absence-study',
                    extra: {
                      'masjidId': masjid.masjidId,
                      'masjidSlug': masjid.slug,
                    },
                  ),
            ),
            _menuItem(
              Icons.calendar_month,
              "Jadwal Kajian",
              onTap: () => context.push('/masjid/${masjid.slug}/agenda'),
            ),
            _menuItem(
              Icons.event_note_sharp,
              "Acara",
              onTap:
                  () => context.push(
                    '/masjid/${masjid.slug}/event',
                    extra: masjid.masjidId,
                  ),
            ),
            _menuItem(
              Icons.workspace_premium,
              "Sertifikat",
              onTap: () => context.push('/masjid/${masjid.slug}/certificate'),
            ),
            _menuItem(
              Icons.person,
              "Profil",
              onTap:
                  () => context.push(
                    '/masjid/${masjid.slug}/profile',
                    extra: masjid,
                  ),
            ),
          ],
        ),
      );
    } else if (selectedTabIndex == 1) {
      final filteredPosts = posts;
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
      );
    }
    return const SizedBox();
  }

  Widget _menuItem(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
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

  void _showLoginPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Login Diperlukan"),
            content: const Text(
              "Silakan login terlebih dahulu untuk mengikuti masjid ini.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/login');
                },
                child: const Text("Login"),
              ),
            ],
          ),
    );
  }
}
