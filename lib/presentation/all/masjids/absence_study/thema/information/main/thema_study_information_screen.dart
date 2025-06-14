import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lectures_model.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/info_item_component.dart';

class DetailThemaStudyInformationScreen extends StatelessWidget {
  const DetailThemaStudyInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Terima data dari route
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final MasjidLectureModel? lecture = extra?['lecture'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body:
          lecture == null
              ? const Center(child: Text("Data tidak tersedia."))
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16,
                ),
                child: InfoSection(lecture: lecture),
              ),
    );
  }
}
