import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/study/main/cubit/material_asset_cubit.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/study/main/cubit/material_asset_state.dart';
import 'package:go_router/go_router.dart';

class DocsThemaScreen extends StatefulWidget {
  final String lectureId;

  const DocsThemaScreen({super.key, required this.lectureId});

  @override
  State<DocsThemaScreen> createState() => _DocsThemaScreenState();
}

class _DocsThemaScreenState extends State<DocsThemaScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<LectureSessionMaterialAssetCubit>();
      if (cubit.state is! LectureSessionMaterialAssetLoaded &&
          cubit.state is! LectureSessionMaterialAssetLoading) {
        cubit.fetchByLectureId(widget.lectureId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Materi PDF")),
      body: BlocBuilder<
        LectureSessionMaterialAssetCubit,
        LectureSessionMaterialAssetState
      >(
        builder: (context, state) {
          if (state is LectureSessionMaterialAssetLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LectureSessionMaterialAssetLoaded) {
            final pdfList =
                state.data.where((item) {
                  final url = item.assetFileUrl;
                  return item.type == 'asset' &&
                      item.assetFileType == 2 &&
                      url != null &&
                      url.endsWith(".pdf");
                }).toList();

            if (pdfList.isEmpty) {
              return const Center(child: Text("Belum ada dokumen PDF."));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: pdfList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final pdf = pdfList[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // tileColor: Colors.grey.shade100,
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: Text(
                    pdf.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    context.push(
                      '/pdf-viewer',
                      extra: {'title': pdf.title, 'url': pdf.assetFileUrl!},
                    );
                  },
                );
              },
            );
          }

          return const Center(child: Text("Gagal memuat data."));
        },
      ),
    );
  }
}
