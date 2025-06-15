import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:masjidku/presentation/all/masjids/absence_study/study/main/cubit/material_asset_cubit.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/study/main/cubit/material_asset_state.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/study/main/model/lecture_session_material_asset_model.dart';

class ThemeStudySummaryScreen extends StatefulWidget {
  final String lectureId;

  const ThemeStudySummaryScreen({super.key, required this.lectureId});

  @override
  State<ThemeStudySummaryScreen> createState() =>
      _ThemeStudySummaryScreenState();
}

class _ThemeStudySummaryScreenState extends State<ThemeStudySummaryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<LectureSessionMaterialAssetCubit>();
      final state = cubit.state;
      if (state is! LectureSessionMaterialAssetLoaded &&
          state is! LectureSessionMaterialAssetLoading) {
        cubit.fetchByLectureId(widget.lectureId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Ringkasan Materi")),
      body: BlocBuilder<
        LectureSessionMaterialAssetCubit,
        LectureSessionMaterialAssetState
      >(
        builder: (context, state) {
          if (state is LectureSessionMaterialAssetLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LectureSessionMaterialAssetLoaded) {
            final List<LectureSessionMaterialAssetModel> summaryList =
                state.data
                    .where(
                      (item) =>
                          item.type == 'material' &&
                          (item.materialSummary?.trim().isNotEmpty ?? false),
                    )
                    .toList();

            if (summaryList.isEmpty) {
              return const Center(child: Text("Belum ada ringkasan materi."));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: summaryList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final material = summaryList[index];
                return _buildSummaryTile(context, material);
              },
            );
          }

          return const Center(child: Text("Gagal memuat data."));
        },
      ),
    );
  }

  Widget _buildSummaryTile(
    BuildContext context,
    LectureSessionMaterialAssetModel material,
  ) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: const Icon(Icons.description, color: Colors.green),
      title: Text(
        material.title.trim().isNotEmpty
            ? material.title
            : 'Judul tidak tersedia',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        material.materialSummary?.trim() ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        context.push(
          '/material-summary-view',
          extra: {
            'title': material.title,
            'content': material.materialSummary ?? '',
          },
        );
      },
    );
  }
}
