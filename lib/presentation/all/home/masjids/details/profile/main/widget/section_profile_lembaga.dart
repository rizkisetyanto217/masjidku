import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/presentation/all/home/masjids/details/profile/main/masjid_profile_main_screen.dart';
import '../cubit/masjid_profile_cubit.dart';
import '../cubit/masjid_profile_state.dart';
import 'package:go_router/go_router.dart';
// import 'package:masjidku/component/shared/section_title.dart'; // misal kamu punya komponen ini

class SectionProfilLembaga extends StatelessWidget {
  final String masjidId;

  const SectionProfilLembaga({super.key, required this.masjidId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              MasjidProfileCubit()
                ..fetchMasjidProfile(masjidId), // ✅ versi tanpa ApiService
      child: BlocBuilder<MasjidProfileCubit, MasjidProfileState>(
        builder: (context, state) {
          if (state is MasjidProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MasjidProfileLoaded) {
            final profile = state.profile;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    icon: Icons.menu_book,
                    title: "Profil Lembaga",
                  ),
                  const SizedBox(height: 8),
                  Text(profile.story, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed:
                          () => context.push(
                            '/masjid/${profile.masjidId}/profile/full-profile',
                            extra: profile, // ✅ hanya dikirim ke full-profile
                          ),

                      icon: const Icon(Icons.chevron_right),
                      label: const Text("Profil Lengkap"),
                      style: OutlinedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is MasjidProfileError) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text(state.message),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
