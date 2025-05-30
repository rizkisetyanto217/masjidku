import 'package:flutter/material.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class DonationHistoryScreen extends StatefulWidget {
  const DonationHistoryScreen({super.key});

  @override
  State<DonationHistoryScreen> createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
  int selectedTab = 1; // Default ke "Masjid"
  String selectedFilter = 'Semua';

  final List<Map<String, dynamic>> donations = [
    {
      'masjid': 'Masjid At-Taqwa',
      'amount': '100.000',
      'date': '3 Dzulhijjah 1445 H / 4 November 2025 M',
      'highlight': true,
    },
    {
      'masjid': 'Masjidku',
      'amount': '10.000',
      'date': '3 Dzulhijjah 1445 H / 4 November 2025 M',
      'highlight': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Donasi Saya"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 8)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabSwitcher(),
            const SizedBox(height: 16),
            _buildFilterDropdown(),
            const SizedBox(height: 16),
            ..._buildContentByTab(),
            const Spacer(),
            MainButton(label: "Donasi Sekarang", onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _buildTab(0, 'Pengumuman', Icons.announcement),
          _buildTab(1, 'Masjid', Icons.mosque),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String label, IconData icon) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.teal : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16),
              const SizedBox(width: 4),
              Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return DropdownButton<String>(
      value: selectedFilter,
      items:
          [
            'Semua',
            'Masjidku',
            'Lainnya',
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (val) => setState(() => selectedFilter = val!),
      underline: Container(height: 0),
      borderRadius: BorderRadius.circular(12),
    );
  }

  List<Widget> _buildContentByTab() {
    if (selectedTab == 1) {
      return [
        const SizedBox(height: 48),
        Center(
          child: Icon(
            Icons.announcement_outlined,
            size: 48,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            "Belum ada pengumuman.",
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      ];
    }

    return donations.map(_buildDonationItem).toList();
  }

  Widget _buildDonationItem(Map<String, dynamic> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item['masjid'],
          style: TextStyle(
            color: item['highlight'] ? Colors.green : Colors.teal,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Rp. ${item['amount']}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 2),
        Text(
          item['date'],
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 16),
        const Divider(height: 1),
        const SizedBox(height: 16),
      ],
    );
  }
}
