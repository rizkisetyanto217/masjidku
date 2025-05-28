import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AbsenceStudyMasjidScreen extends StatefulWidget {
  const AbsenceStudyMasjidScreen({super.key});

  @override
  State<AbsenceStudyMasjidScreen> createState() =>
      _AbsenceStudyMasjidScreenState();
}

class _AbsenceStudyMasjidScreenState extends State<AbsenceStudyMasjidScreen> {
  int selectedTab = 0; // 0: Terbaru, 1: Tema, 2: Bulan
  final List<String> tabTitles = ['Terbaru', 'Tema', 'Bulan'];
  String selectedOrder = 'Terbaru';

  final List<Map<String, dynamic>> items = [
    {
      "title": "Rencana Allah yang terbaik",
      "teacher": "Ustadz Abdullah",
      "date": "4 Maret 2025, Pukul 10.00 WIB - Selesai",
      "tags": [
        _StatusTag("Status Kehadiran", Color(0xFFFFB74D), Colors.black),
        _StatusTag("Materi & Soal Tersedia", Color(0xFF0097A7), Colors.white),
      ],
    },
    {
      "title": "Rencana Allah yang terbaik",
      "teacher": "Ustadz Abdullah",
      "date": "4 Maret 2025, Pukul 10.00 WIB - Selesai",
      "tags": [_StatusTag("Hadir Langsung ✅", Color(0xFF4CAF50), Colors.white)],
    },
  ];

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
            // TabBar Filter
            _TabSelector(
              selectedIndex: selectedTab,
              onChanged: (index) => setState(() => selectedTab = index),
            ),

            const SizedBox(height: 16),

            // Dropdown Urutan
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
              // const SizedBox(height: 16),
            ],
            const SizedBox(height: 16),

            // Card List
            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: [
                  // Tab 0: Terbaru → daftar absensi
                  ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _AbsenceCard(
                        title: item['title'],
                        teacher: item['teacher'],
                        date: item['date'],
                        tags: List<_StatusTag>.from(item['tags']),
                      );
                    },
                  ),

                  // Tab 1: Tema
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
                            color: Color(
                              0xFF00796B,
                            ), // Warna Primary dari Figma
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

  IconData _tabIcon(int index) {
    switch (index) {
      case 0:
        return Icons.arrow_outward_rounded;
      case 1:
        return Icons.bookmark_border;
      case 2:
        return Icons.calendar_today_outlined;
      default:
        return Icons.circle;
    }
  }
}

class _AbsenceCard extends StatelessWidget {
  final String title;
  final String teacher;
  final String date;
  final List<_StatusTag> tags;

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
