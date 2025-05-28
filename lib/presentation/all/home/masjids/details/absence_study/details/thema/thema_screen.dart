import 'package:flutter/material.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';

class ThemaStudyScreen extends StatefulWidget {
  const ThemaStudyScreen({super.key});

  @override
  State<ThemaStudyScreen> createState() => _ThemaStudyScreenState();
}

class _ThemaStudyScreenState extends State<ThemaStudyScreen> {
  int selectedTab = 0; // 0 = Kajian, 1 = Navigasi

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
            child: _TabSelectorMini(
              tabs: const ["📖 Kajian", "🧭 Navigasi"],
              selectedIndex: selectedTab,
              onChanged: (i) => setState(() => selectedTab = i),
            ),
          ),
          const SizedBox(height: 16),

          if (selectedTab == 0)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const Text(
                    "Terbaru",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  _AbsenceCard(
                    title: "Aqidah Bagian ke-3",
                    teacher: "Ustadz Abdullah",
                    date: "4 Maret 2025, Pukul 10.00 WIB - Selesai",
                    tags: const [
                      _StatusTag(
                        "Status Kehadiran",
                        Color(0xFFFFB74D),
                        Colors.black,
                      ),
                      _StatusTag(
                        "Materi & Soal : 90",
                        Color(0xFF4CAF50),
                        Colors.white,
                      ),
                    ],
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
                      child: _AbsenceCard(
                        title: "Aqidah Bagian ke-${i + 1}",
                        teacher: "Ustadz Abdullah",
                        date: "4 Maret 2025, Pukul 10.00 WIB - Selesai",
                        tags: const [
                          _StatusTag(
                            "Status Kehadiran",
                            Color(0xFFFFB74D),
                            Colors.black,
                          ),
                          _StatusTag(
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
                  // Bagian atas dengan padding
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: _NavigationInfoSection(),
                  ),

                  const SizedBox(height: 20),

                  // Gap tanpa padding
                  const GapBorderSeparator(),

                  const SizedBox(height: 20),
                  Padding(
                     padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12),
                    child: Text(
                      "Menu Navigasi",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00796B),
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // Grid menu dengan padding
                  const Padding(
                     padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: _NavigationMenuGrid(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _TabSelectorMini extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _TabSelectorMini({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = index == selectedIndex;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: OutlinedButton(
              onPressed: () => onChanged(index),
              style: OutlinedButton.styleFrom(
                backgroundColor:
                    isSelected ? const Color(0xFF00796B) : Colors.white,
                side: BorderSide(
                  color: isSelected ? const Color(0xFF00796B) : Colors.grey,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }),
    );
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
        borderRadius: BorderRadius.circular(12),
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

class _NavigationInfoSection extends StatelessWidget {
  const _NavigationInfoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Informasi Tema Kajian",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF00796B),
            fontSize: 16,
          ),

        ),
        SizedBox(height: 8),
        _InfoItem(
          icon: Icons.menu_book_outlined,
          text: "Materi : Kitab Fiqh Syafi’i Matan Abu Syuja’",
        ),
        _InfoItem(
          icon: Icons.person_outline,
          text: "Pengajar : Ustadz Budi Hariadi",
        ),
        _InfoItem(
          icon: Icons.schedule,
          text: "Jadwal : Tiap sabtu pukul 20.00 WIB",
        ),
        _InfoItem(
          icon: Icons.calendar_today_outlined,
          text: "Mulai : 24 Mei 2024 - Sekarang",
        ),
        _InfoItem(
          icon: Icons.location_on_outlined,
          text: "Lokasi : Masjid At–Taqwa, Ciracas",
        ),
        SizedBox(height: 6),
        Text(
          "Sertifikat belum tersedia",
          style: TextStyle(color: Colors.orange),
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
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
      {"icon": Icons.info_outline, "label": "Informasi"},
      {"icon": Icons.assignment_turned_in, "label": "Latihan Soal"},
      {"icon": Icons.menu_book, "label": "Materi Lengkap"},
      {"icon": Icons.notes_outlined, "label": "Ringkasan"},
      {"icon": Icons.question_answer_outlined, "label": "Tanya Jawab"},
      {"icon": Icons.group_outlined, "label": "Catatan Peserta"},
      {"icon": Icons.feedback_outlined, "label": "Masukan dan Saran"},
      {"icon": Icons.pie_chart_outline, "label": "Statistik"},
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
              return Container(
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
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
