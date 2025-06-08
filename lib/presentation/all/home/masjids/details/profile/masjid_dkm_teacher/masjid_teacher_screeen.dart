import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../main/cubit/masjid_profile_dkm_pengajar_cubit.dart';
import '../main/cubit/masjid_profile_dkm_pengajar_state.dart';

class MasjidTeacherScreeen extends StatelessWidget {
  final String slug;
  const MasjidTeacherScreeen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengajar Masjid"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
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
            return Center(child: Text(state.message));
          }

          if (state is MasjidProfileTeacherLoaded) {
            final pengajar =
                state.speeches
                    .where((e) => e.role.toLowerCase().contains('pengajar'))
                    .toList();

            if (pengajar.isEmpty) {
              return const Center(child: Text("Belum ada data pengajar."));
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: pengajar.length,
              separatorBuilder: (_, __) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final item = pengajar[index];

                return ListTile(
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(item.description ?? 'Pengajar Masjid'),
                  contentPadding: EdgeInsets.zero,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Tambah jika ada halaman detail
                    // context.go('/masjid/$slug/profile/teacher/${item.id}');
                  },
                );
              },
            );
          }

          return const SizedBox(); // fallback
        },
      ),
    );
  }
}
