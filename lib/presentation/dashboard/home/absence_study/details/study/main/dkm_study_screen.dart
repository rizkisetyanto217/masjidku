import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DkmStudyScreen extends StatefulWidget {
  const DkmStudyScreen({super.key});

  @override
  State<DkmStudyScreen> createState() => _DkmStudyScreenState();
}

class _DkmStudyScreenState extends State<DkmStudyScreen> {
  int selectedTabIndex = 0;

  static const List<Map<String, dynamic>> menuItems = [
    {'label': 'Informasi', 'icon': Icons.home},
    {'label': 'Latihan Soal', 'icon': Icons.assignment},
    {'label': 'Materi Lengkap', 'icon': Icons.menu_book},
    {'label': 'Ringkasan', 'icon': Icons.description},
    {'label': 'Video Rekaman', 'icon': Icons.play_circle},
    {'label': 'Tanya Jawab', 'icon': Icons.question_answer},
    {'label': 'Statistik', 'icon': Icons.pie_chart},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail kajian"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _InfoRow(
                  icon: Icons.menu_book,
                  text:
                      "Materi : Bab 5 - Wudhu dengan sempurna ( Pertemuan ke-5 )",
                ),
                SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.person,
                  text: "Pengajar : Ustadz Budi Hariadi",
                ),
                SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.schedule,
                  text: "Jadwal : Tiap sabtu pukul 20.00 WIB",
                ),
                SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.verified,
                  text: "Status : Kajian sudah berhasil dipublish",
                  valueColor: Colors.green,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTabItem("Menu Utama", 0),
                _buildTabItem("Pengaturan", 1),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                selectedTabIndex == 0
                    ? Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children:
                          menuItems.map((item) {
                            return SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width -
                                      16 * 2 -
                                      12 * 3) /
                                  4,
                              child: _MenuItem(
                                icon: item['icon'],
                                label: item['label'],
                                onTap: () {
                                  switch (item['label']) {
                                    case 'Informasi':
                                      context.go(
                                        '/dkm/study/study/information',
                                      );
                                      break;
                                    case 'Latihan Soal':
                                      context.go('/dkm/study/study/quiz');
                                      break;
                                    case 'Materi Lengkap':
                                      context.go(
                                        '/dkm/study/study/transcription',
                                      );
                                      break;
                                    case 'Ringkasan':
                                      context.go('/dkm/study/study/summary');
                                      break;
                                    case 'Video Rekaman':
                                      context.go('/dkm/study/study/video');
                                      break;
                                    case 'Tanya Jawab':
                                      context.go('/dkm/study/study/faq');
                                      break;
                                    case 'Statistik':
                                      context.go('/dkm/study/study/stats');
                                      break;
                                    default:
                                      break;
                                  }
                                },
                              ),
                            );
                          }).toList(),
                    )
                    : Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.teal.shade100),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.verified_user,
                                color: Colors.teal,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Konfirmasi Pengajar",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Persetujuan pengajar terkait materi yang akan dipublikasikan DKM Masjid",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Publish",
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: menuItems.length,
                          itemBuilder: (context, index) {
                            final item = menuItems[index];
                            return SettingToggleItem(
                              icon: item['icon'],
                              label: item['label'],
                              isVisible: index != 1,
                              onToggle: () {},
                            );
                          },
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    final isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? valueColor;

  const _InfoRow({required this.icon, required this.text, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: valueColor ?? Colors.black87),
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.teal),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingToggleItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isVisible;
  final VoidCallback onToggle;

  const SettingToggleItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isVisible,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          TextButton(
            onPressed: onToggle,
            child: Text(
              isVisible ? 'Sembunyikan' : 'Tampilkan',
              style: TextStyle(color: isVisible ? Colors.orange : Colors.teal),
            ),
          ),
        ],
      ),
    );
  }
}
