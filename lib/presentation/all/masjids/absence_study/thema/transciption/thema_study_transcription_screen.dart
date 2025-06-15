import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:masjidku/presentation/all/masjids/absence_study/study/main/cubit/material_asset_cubit.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/study/main/cubit/material_asset_state.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/study/main/model/lecture_session_material_asset_model.dart';

class ThemeStudyTranscriptionScreen extends StatefulWidget {
  final String lectureId;

  const ThemeStudyTranscriptionScreen({super.key, required this.lectureId});

  @override
  State<ThemeStudyTranscriptionScreen> createState() =>
      _ThemeStudyTranscriptionScreenState();
}

class _ThemeStudyTranscriptionScreenState
    extends State<ThemeStudyTranscriptionScreen> {
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
      appBar: AppBar(title: const Text("Daftar Materi Transkrip")),
      body: BlocBuilder<
        LectureSessionMaterialAssetCubit,
        LectureSessionMaterialAssetState
      >(
        builder: (context, state) {
          if (state is LectureSessionMaterialAssetLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LectureSessionMaterialAssetLoaded) {
            final List<LectureSessionMaterialAssetModel> transcriptList =
                state.data
                    .where(
                      (item) =>
                          item.type == 'material' &&
                          (item.materialTranscriptFull?.trim().isNotEmpty ??
                              false),
                    )
                    .toList();

            if (transcriptList.isEmpty) {
              return const Center(child: Text("Belum ada transkrip materi."));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: transcriptList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final material = transcriptList[index];
                return _buildTranscriptTile(context, material);
              },
            );
          }

          return const Center(child: Text("Gagal memuat data."));
        },
      ),
    );
  }

  Widget _buildTranscriptTile(
    BuildContext context,
    LectureSessionMaterialAssetModel material,
  ) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: const Icon(Icons.article, color: Colors.blue),
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
          '/material-transcript-view',
          extra: {
            'title': material.title,
            'content': material.materialTranscriptFull ?? '',
          },
        );
      },
    );
  }
}
