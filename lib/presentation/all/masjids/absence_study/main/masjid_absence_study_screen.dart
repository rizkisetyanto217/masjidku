import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/cubit/masjid_lecture_sessions_cubit.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/cubit/masjid_lecture_sessions_state.dart';

class MasjidAbsenceStudyScreen extends StatefulWidget {
  const MasjidAbsenceStudyScreen({super.key});

  @override
  State<MasjidAbsenceStudyScreen> createState() =>
      _MasjidAbsenceStudyScreenState();
}

class _MasjidAbsenceStudyScreenState extends State<MasjidAbsenceStudyScreen> {
  int selectedTab = 0;
  String selectedOrder = 'Terbaru';

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final masjidId = GoRouterState.of(context).extra as String?;
      if (masjidId != null) {
        print('[🕌 INIT] MasjidID ditemukan: $masjidId');
        context.read<MasjidLectureSessionsCubit>().fetchAbsenceStudy(
          masjidId: masjidId,
        );
      } else {
        print('[⚠️ INIT] MasjidID tidak ditemukan di extra');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Absensi & Belajar"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TabSelector(
              selectedIndex: selectedTab,
              onChanged: (index) => setState(() => selectedTab = index),
            ),
            const SizedBox(height: 16),

            if (selectedTab == 0) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedOrder,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items:
                      ['Terbaru', 'Terlama']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => selectedOrder = val);
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],

            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: [
                  // ✅ Tab 0: Daftar Absensi (pakai BlocBuilder)
                  BlocBuilder<
                    MasjidLectureSessionsCubit,
                    MasjidLectureSessionsState
                  >(
                    builder: (context, state) {
                      if (state is AbsenceStudyLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AbsenceStudyLoaded) {
                        final items = state.items;

                        if (items.isEmpty) {
                          return const Center(child: Text("Belum ada data."));
                        }

                        return ListView.separated(
                          itemCount: items.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = items[index];

                            // Buat daftar tag
                            final List<Widget> tags = [];

                            // Status kehadiran
                            if (item.attendanceStatusText != null) {
                              tags.add(
                                _StatusTag(
                                  item.attendanceStatusText!,
                                  Colors.green.shade600,
                                  Colors.white,
                                ),
                              );
                            } else {
                              tags.add(
                                _StatusTag(
                                  "Status Kehadiran -",
                                  Colors.amber.shade700,
                                  Colors.black,
                                ),
                              );
                            }

                            // Nilai (grade)
                            if (item.userGradeResult != null) {
                              final grade = item.userGradeResult!;
                              final color =
                                  grade >= 80
                                      ? Colors.blue.shade700
                                      : grade >= 60
                                      ? Colors.orange.shade700
                                      : Colors.red.shade600;

                              tags.add(
                                _StatusTag(
                                  "Nilai: $grade",
                                  color,
                                  Colors.white,
                                ),
                              );
                            }

                            return _AbsenceCard(
                              title: item.title,
                              teacher: item.teacherName ?? "-",
                              date: item.sessionTimeFormatted,
                              tags: tags,
                            );
                          },
                        );
                      } else if (state is AbsenceStudyError) {
                        return Center(child: Text(state.message));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),

                  // Tab 1: Tema
                  ListView(
                    children: [
                      _TemaProgressCard(
                        title: "Kajian Aqidah",
                        progress: 10,
                        total: 15,
                      ),
                      const SizedBox(height: 12),
                      _TemaListCard(
                        title: "Kajian Fiqh",
                        subtitle: "12 Kajian tatap muka",
                        onTap:
                            () =>
                                context.go('/masjid/absence-study/thema-study'),
                      ),
                      const SizedBox(height: 12),
                      _TemaListCard(
                        title: "Kajian Tematik",
                        subtitle: "12 Kajian tatap online",
                        onTap: () {},
                      ),
                    ],
                  ),

                  // Tab 2: Bulan
                  ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Tahun 2025",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF00796B),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _TemaListCard(
                        title: "Januari",
                        subtitle: "12 Kajian dilaksanakan",
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      _TemaListCard(
                        title: "Februari",
                        subtitle: "12 Kajian dilaksanakan",
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      _TemaListCard(
                        title: "Maret",
                        subtitle: "12 Kajian dilaksanakan",
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// IconData _tabIcon(int index) {
//   switch (index) {
//     case 0:
//       return Icons.arrow_outward_rounded;
//     case 1:
//       return Icons.bookmark_border;
//     case 2:
//       return Icons.calendar_today_outlined;
//     default:
//       return Icons.circle;
//   }
// }

class _AbsenceCard extends StatelessWidget {
  final String title;
  final String teacher;
  final String date;
  final List<Widget> tags;

  const _AbsenceCard({
    required this.title,
    required this.teacher,
    required this.date,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(8),
        // color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(teacher, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.circle, size: 8, color: Colors.black),
              const SizedBox(width: 6),
              Text(date, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: tags),
        ],
      ),
    );
  }
}

class _StatusTag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const _StatusTag(this.text, this.backgroundColor, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}

class _TabSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _TabSelector({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabs = [
      {"label": "Terbaru", "icon": Icons.arrow_outward_rounded},
      {"label": "Tema", "icon": Icons.bookmark_border},
      {"label": "Bulan", "icon": Icons.calendar_today_outlined},
    ];

    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = index == selectedIndex;
        final tab = tabs[index];

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: OutlinedButton.icon(
              onPressed: () => onChanged(index),
              icon: Icon(
                tab['icon'],
                size: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
              label: Text(
                tab['label'],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor:
                    isSelected ? const Color(0xFF00796B) : Colors.white,
                side: BorderSide(
                  color: isSelected ? const Color(0xFF00796B) : Colors.grey,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TemaProgressCard extends StatelessWidget {
  final String title;
  final int progress;
  final int total;

  const _TemaProgressCard({
    required this.title,
    required this.progress,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percent = progress / total;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 10,
              // backgroundColor: Colors.grey.shade200,
              color: const Color(0xFF4CAF50),
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "$progress/$total",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class _TemaListCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _TemaListCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
          ), // ✅ Border ditambahkan
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: 24),
          ],
        ),
      ),
    );
  }
}
