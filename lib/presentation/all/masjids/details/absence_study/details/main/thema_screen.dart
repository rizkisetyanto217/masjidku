import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
import 'package:masjidku/component/main/home/tab_switch_component.dart';
import 'package:masjidku/presentation/all/masjids/details/absence_study/details/components/info_item_component.dart';
import 'package:masjidku/presentation/all/masjids/details/absence_study/details/components/status_tag_component.dart';
import 'package:masjidku/presentation/all/masjids/details/absence_study/details/components/study_card_component.dart';
// import 'package:masjidku/component/main/tab/tab_switch.dart';

class ThemaStudyScreen extends StatefulWidget {
  const ThemaStudyScreen({super.key});

  @override
  State<ThemaStudyScreen> createState() => _ThemaStudyScreenState();
}

class _ThemaStudyScreenState extends State<ThemaStudyScreen> {
  String selectedTab = "📖 Kajian"; // default tab
  final List<String> tabTitles = ["📖 Kajian", "🧭 Navigasi"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kajian Aqidah"),
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
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const Text(
                    "Terbaru",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  StudyCard(
                    title: "Aqidah Bagian ke-3",
                    teacher: "Ustadz Abdullah",
                    date: "4 Maret 2025, Pukul 10.00 WIB - Selesai",
                    tags: const [
                      StatusTag(
                        "Status Kehadiran",
                        Color(0xFFFFB74D),
                        Colors.black,
                      ),
                      StatusTag(
                        "Materi & Soal : 90",
                        Color(0xFF4CAF50),
                        Colors.white,
                      ),
                    ],
                    onTap:
                        () => GoRouter.of(
                          context,
                        ).go('/masjid/absence-study/study'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Urutan",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(3, (i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: StudyCard(
                        title: "Aqidah Bagian ke-${i + 1}",
                        teacher: "Ustadz Abdullah",
                        date: "4 Maret 2025, Pukul 10.00 WIB - Selesai",
                        tags: const [
                          StatusTag(
                            "Status Kehadiran",
                            Color(0xFFFFB74D),
                            Colors.black,
                          ),
                          StatusTag(
                            "Materi & Soal : 90",
                            Color(0xFF4CAF50),
                            Colors.white,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            )
          else
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: InfoSection(),
                  ),
                  const SizedBox(height: 20),
                  const GapBorderSeparator(),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 12,
                    ),
                    child: Text(
                      "Menu Navigasi",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00796B),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: _NavigationMenuGrid(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _NavigationMenuGrid extends StatelessWidget {
  const _NavigationMenuGrid();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menus = [
      {
        "icon": Icons.info_outline,
        "label": "Informasi",
        "route": "/masjid/absence-study/thema-study/information",
      },
      {
        "icon": Icons.video_library_outlined,
        "label": "Video",
        "route": "/masjid/absence-study/thema-study/video",
      },
      {
        "icon": Icons.assignment_turned_in,
        "label": "Latihan Soal",
        "route": "/masjid/absence-study/thema-study/quiz",
      },
      {
        "icon": Icons.menu_book,
        "label": "Materi Lengkap",
        "route": "/masjid/absence-study/thema-study/transcription",
      },
      {
        "icon": Icons.notes_outlined,
        "label": "Ringkasan",
        "route": "/masjid/absence-study/thema-study/summary",
      },
      {
        "icon": Icons.question_answer_outlined,
        "label": "Tanya Jawab",
        "route": "/masjid/absence-study/thema-study/faq",
      },
      {
        "icon": Icons.group_outlined,
        "label": "Catatan Peserta",
        "route": "/masjid/absence-study/thema-study/note",
      },
      {
        "icon": Icons.feedback_outlined,
        "label": "Masukan dan Saran",
        "route": "/masjid/absence-study/thema-study/suggestion",
      },
      {
        "icon": Icons.pie_chart_outline,
        "label": "Statistik",
        "route": "/masjid/absence-study/thema-study/stats",
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
                onTap: () => GoRouter.of(context).go(item['route']),
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
