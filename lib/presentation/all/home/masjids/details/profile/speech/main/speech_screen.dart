import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main/cubit/masjid_profile_dkm_pengajar_cubit.dart';
import '../../main/cubit/masjid_profile_dkm_pengajar_state.dart';
import 'package:masjidku/presentation/all/home/masjids/details/profile/main/widget/speech_card_component.dart';

class SpeechScreen extends StatelessWidget {
  final String slug;
  const SpeechScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sambutan Masjid"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<MasjidProfileTeacherCubit, MasjidProfileTeacherState>(
        builder: (context, state) {
          if (state is MasjidProfileTeacherLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MasjidProfileTeacherError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is MasjidProfileTeacherLoaded) {
            final speeches =
                state.speeches.where((e) => e.message.isNotEmpty).toList();
            if (speeches.isEmpty) {
              return const Center(child: Text("Belum ada sambutan."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: speeches.length,
              itemBuilder: (context, index) {
                final data = speeches[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SpeechCard(
                    name: data.name,
                    role: data.role,
                    message: data.message,
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
