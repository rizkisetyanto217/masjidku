import 'package:flutter/material.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';

class DkmThemaScreen extends StatefulWidget {
  const DkmThemaScreen({super.key});

  @override
  State<DkmThemaScreen> createState() => _DkmThemaScreenState();
}

class _DkmThemaScreenState extends State<DkmThemaScreen> {
  int selectedTabIndex = 0;

  static const List<Map<String, dynamic>> menuItems = [
    {'label': 'Informasi', 'icon': Icons.home},
    {'label': 'Tanya Jawab', 'icon': Icons.question_answer},
    {'label': 'Statistik', 'icon': Icons.pie_chart},
    {'label': 'Sertifikat', 'icon': Icons.badge},
    {'label': 'Masukan & Saran', 'icon': Icons.feedback},
  ];

  final List<Map<String, String>> babList = [
    {"judul": "Bab 1 - Wudhu dengan sempurna", "pertemuan": "Pertemuan ke-1"},
    {"judul": "Bab 2 - Wudhu dengan sempurna", "pertemuan": "Pertemuan ke-2"},
    {"judul": "Bab 3 - Wudhu dengan sempurna", "pertemuan": "Pertemuan ke-2"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kajian Fiqh"),
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
          _buildKajianInfoCard(),
          const GapBorderSeparator(),
          const SizedBox(height: 16),
          _buildTabBar(context),
          const SizedBox(height: 16),
          selectedTabIndex == 1
              ? _buildPengaturanGrid(context)
              : _buildBabList(),
        ],
      ),
    );
  }

  Widget _buildKajianInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.menu_book, "Materi: Kitab Fiqh Waris"),
          _buildInfoRow(Icons.person, "Pengajar: Ustadz Budi Hariadi"),
          _buildInfoRow(Icons.calendar_today, "Mulai: 24 Mei 2024 - Sekarang"),
          _buildInfoRow(
            Icons.info_outline,
            "Status: Kajian sedang berjalan",
            valueColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildTabItem(context, "Kajian Saya", 0),
          _buildTabItem(context, "Pengaturan", 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String label, int index) {
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPengaturanGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children:
            menuItems.map((item) {
              return SizedBox(
                width:
                    (MediaQuery.of(context).size.width - 16 * 2 - 12 * 3) / 4,
                child: DkmThemaMenuItem(
                  icon: item['icon'],
                  label: item['label'],
                  onTap: () {},
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildBabList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            babList.map((bab) {
              return DkmBabCard(
                title: bab["judul"]!,
                subtitle: bab["pertemuan"]!,
              );
            }).toList(),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: valueColor))),
        ],
      ),
    );
  }
}

class DkmThemaMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const DkmThemaMenuItem({
    super.key,
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
          border: Border.all(color: Colors.grey.shade400, width: 1.2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
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

class DkmBabCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const DkmBabCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400, width: 1.2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
