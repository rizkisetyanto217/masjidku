import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
import 'package:masjidku/component/main/home/tab_switch_component.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/main/cubit/theme_lectures_state.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/main/cubit/thema_lectures_cubit.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lectures_model.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/info_item_component.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/status_tag_component.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/study_card_component.dart';

class ThemaStudyScreen extends StatefulWidget {
  final MasjidLectureModel data;
  final String masjidSlug;

  const ThemaStudyScreen({
    super.key,
    required this.data,
    required this.masjidSlug,
  });

  @override
  State<ThemaStudyScreen> createState() => _ThemaStudyScreenState();
}

class _ThemaStudyScreenState extends State<ThemaStudyScreen> {
  String selectedTab = "📖 Kajian";
  final List<String> tabTitles = ["📖 Kajian", "🧭 Navigasi"];

  @override
  void initState() {
    super.initState();
    context.read<ThemeLectureCubit>().fetchThemeLectures(
      masjidId: widget.data.masjidId,
      lectureId: widget.data.lectureId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lecture = widget.data;

    return Scaffold(
      appBar: AppBar(
        title: Text(lecture.lectureTitle),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: TabSwitch(
              tabs: tabTitles,
              selectedTab: selectedTab,
              onChanged: (label) => setState(() => selectedTab = label),
            ),
          ),
          const SizedBox(height: 16),
          if (selectedTab == "📖 Kajian")
            Expanded(
              child: BlocBuilder<ThemeLectureCubit, ThemeLectureState>(
                builder: (context, state) {
                  if (state is ThemeLectureLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ThemeLectureError) {
                    return Center(child: Text(state.message));
                  } else if (state is ThemeLectureLoaded) {
                    final sessions = state.sessions;
                    if (sessions.isEmpty) {
                      return const Center(
                        child: Text("Belum ada sesi kajian."),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: sessions.length,
                      itemBuilder: (context, index) {
                        final session = sessions[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: StudyCard(
                            title: session.title,
                            teacher: session.teacherName ?? "-",
                            date: session.sessionTimeFormatted,
                            tags: [
                              StatusTag(
                                session.attendanceStatusText ??
                                    "Belum diketahui",
                                const Color(0xFFFFB74D),
                                Colors.black,
                              ),
                              StatusTag(
                                "Materi & Soal : ${session.userGradeResult ?? '-'}",
                                const Color(0xFF4CAF50),
                                Colors.white,
                              ),
                            ],
                            onTap: () {
                              context.push(
                                '/masjid/${widget.masjidSlug}/absence-study/study/${session.id}',
                                extra: {
                                  "session": session,
                                  "masjidSlug": widget.masjidSlug,
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            )
          else
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: InfoSection(lecture: widget.data),
                  ),
                  SizedBox(height: 20),
                  GapBorderSeparator(),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Menu Navigasi",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00796B),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),

                    child: _NavigationMenuGrid(
                      masjidSlug: widget.masjidSlug,
                      lectureId: widget.data.lectureId,
                      lecture: widget.data, // 👈 kirim MasjidLectureModel
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _NavigationMenuGrid extends StatelessWidget {
  final String masjidSlug;
  final String lectureId;
  final MasjidLectureModel lecture; // 👈 Tambahkan ini

  const _NavigationMenuGrid({
    required this.masjidSlug,
    required this.lectureId,
    required this.lecture,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menus = [
      {
        "icon": Icons.info_outline,
        "label": "Informasi",
        "route": "/masjid/$masjidSlug/absence-study/thema-study/information",
        "extra": {
          "lecture": lecture, // <- kirim data di sini
        },
      },
      {
        "icon": Icons.video_library_outlined,
        "label": "Video",
        "route":
            "/masjid/$masjidSlug/absence-study/thema-study/video/$lectureId",
      },
      {
        "icon": Icons.assignment_turned_in,
        "label": "Latihan Soal",
        "route": "/masjid/$masjidSlug/absence-study/thema-study/quiz",
        "extra": {
          "lectureId": lectureId,
          "lecture": lecture,
          "masjidSlug": masjidSlug,
        },
      },
      {
        "icon": Icons.menu_book,
        "label": "Materi Lengkap",
        "route":
            "/masjid/$masjidSlug/absence-study/thema-study/transcription/$lectureId",
      },
      {
        "icon": Icons.notes_outlined,
        "label": "Ringkasan",
        "route":
            "/masjid/$masjidSlug/absence-study/thema-study/summary/$lectureId",
      },
      {
        "icon": Icons.question_answer_outlined,
        "label": "Tanya Jawab",
        "route": "/masjid/$masjidSlug/absence-study/thema-study/faq",
      },
      {
        "icon": Icons.group_outlined,
        "label": "Catatan Peserta",
        "route": "/masjid/$masjidSlug/absence-study/thema-study/note",
      },
      {
        "icon": Icons.feedback_outlined,
        "label": "Masukan dan Saran",
        "route": "/masjid/$masjidSlug/absence-study/thema-study/suggestion",
      },
      {
        "icon": Icons.feedback_outlined,
        "label": "Dokumen",
        "route":
            "/masjid/$masjidSlug/absence-study/thema-study/document/$lectureId",
      },
      {
        "icon": Icons.pie_chart_outline,
        "label": "Statistik",
        "route": "/masjid/$masjidSlug/absence-study/thema-study/stats",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GridView.count(
        crossAxisCount: 1,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 6,
        children:
            menus.map((item) {
              return GestureDetector(
                onTap:
                    () => context.push(
                      item['route'],
                      extra: item['extra'], // <- pastikan ini disediakan
                    ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Icon(item['icon'], color: const Color(0xFF00796B)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item['label'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
