import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/presentation/all/home/search/cubit/masjid_followed_cubit.dart';
import 'package:masjidku/presentation/all/home/search/cubit/masjid_followed_state.dart';
import '../cubit/masjid_cubit.dart';
import '../cubit/masjid_state.dart';
import 'masjid_list_tile.dart';

class MasjidListSection extends StatelessWidget {
  final int selectedTab;
  final String query;

  const MasjidListSection({
    super.key,
    required this.selectedTab,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedTab == 0) {
      return BlocBuilder<MasjidCubit, MasjidState>(
        builder: (context, state) {
          if (state is MasjidLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MasjidLoaded) {
            final filtered =
                state.masjids.where((masjid) {
                  return masjid.masjidName.toLowerCase().contains(query) ||
                      masjid.masjidLocation.toLowerCase().contains(query);
                }).toList();

            if (filtered.isEmpty) {
              return const Center(child: Text("Tidak ditemukan."));
            }

            return ListView.builder(
              itemCount: filtered.length,
              itemBuilder:
                  (context, index) => MasjidListTile(masjid: filtered[index]),
            );
          } else if (state is MasjidError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      );
    } else {
      return BlocBuilder<MasjidFollowedCubit, MasjidFollowedState>(
        builder: (context, state) {
          if (state is MasjidFollowedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MasjidFollowedLoaded) {
            final filtered =
                state.masjids.where((masjid) {
                  return masjid.masjidName.toLowerCase().contains(query) ||
                      masjid.masjidLocation.toLowerCase().contains(query);
                }).toList();

            if (filtered.isEmpty) {
              return const Center(
                child: Text("Belum ada masjid yang kamu ikuti."),
              );
            }

            return ListView.builder(
              itemCount: filtered.length,
              itemBuilder:
                  (context, index) => MasjidListTile(masjid: filtered[index]),
            );
          } else if (state is MasjidFollowedError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      );
    }
  }
}
