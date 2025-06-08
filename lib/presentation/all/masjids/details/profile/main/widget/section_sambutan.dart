import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/presentation/all/masjids/model/masjid_detail_profile.dart';
// import '../model/masjid_profile_dkm_pengajar_model.dart';
import '../cubit/masjid_profile_dkm_pengajar_cubit.dart';
import '../cubit/masjid_profile_dkm_pengajar_state.dart';
import 'package:masjidku/presentation/all/masjids/details/profile/main/widget/speech_card_component.dart';

class SectionSambutan extends StatelessWidget {
  final String slug;
  final MasjidDetailModel masjid;

  const SectionSambutan({super.key, required this.slug, required this.masjid});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasjidProfileTeacherCubit, MasjidProfileTeacherState>(
      builder: (context, state) {
        if (state is MasjidProfileTeacherLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MasjidProfileTeacherError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is MasjidProfileTeacherLoaded) {
          final speeches = state.speeches;
          if (speeches.isEmpty) return const SizedBox();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "🗣️ Sambutan dan Motivasi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF00796B),
                  ),
                ),
                const SizedBox(height: 8),
                const Text("Tulisan dari pengurus, pengajar dan jamaah Masjid"),
                const SizedBox(height: 12),
                ...speeches
                    .take(2)
                    .map(
                      (e) => Column(
                        children: [
                          SpeechCard(
                            name: e.name,
                            role: e.role,
                            message: e.message,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                OutlinedButton.icon(
                  onPressed:
                      () => context.push(
                        '/masjid/$slug/profile/speech',
                        extra: masjid, // MasjidDetailModel
                      ),
                  icon: const Icon(Icons.chevron_right),
                  label: const Text("Selengkapnya"),
                ),
              ],
            ),
          );
        }

        return const SizedBox(); // Default fallback
      },
    );
  }
}
