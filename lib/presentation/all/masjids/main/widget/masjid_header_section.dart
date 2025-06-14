import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
import 'package:masjidku/core/utils/auth_cubit.dart';
import 'package:masjidku/presentation/all/masjids/main/cubit/masjid_follow_cubit.dart';
import 'package:masjidku/presentation/all/masjids/main/model/masjid_detail_profile.dart';
import 'masjid_header.dart';

class MasjidHeaderSection extends StatelessWidget {
  final MasjidDetailModel masjid;

  const MasjidHeaderSection({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final isLoggedIn = authState.isLoggedIn;
        return Column(
          children: [
            BlocBuilder<MasjidFollowCubit, MasjidFollowState>(
              builder: (context, followState) {
                if (followState.isLoading) {
                  return const CircularProgressIndicator();
                }

                final isFollowing = followState.isFollowing;

                return MasjidHeader(
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
          ],
        );
      },
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
                  context.push('/login');
                },
                child: const Text("Login"),
              ),
            ],
          ),
    );
  }
}
