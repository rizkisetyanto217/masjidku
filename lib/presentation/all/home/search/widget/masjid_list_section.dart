import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/masjid_cubit.dart';
import '../cubit/masjid_state.dart';
import '../model/masjid_model.dart';
import 'masjid_list_tile.dart';

class MasjidListSection extends StatelessWidget {
  final int selectedTab;
  final String query;
  final List<MasjidModel> myMasjid;

  const MasjidListSection({
    super.key,
    required this.selectedTab,
    required this.query,
    required this.myMasjid,
  });

  @override
  Widget build(BuildContext context) {
    return selectedTab == 0
        ? BlocBuilder<MasjidCubit, MasjidState>(
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
        )
        : ListView.builder(
          itemCount: myMasjid.length,
          itemBuilder:
              (context, index) =>
                  MasjidListTile(masjid: myMasjid[index], isAssetImage: true),
        );
  }
}
