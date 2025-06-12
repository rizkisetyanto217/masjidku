import 'package:flutter/material.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  int selectedIndex = 0;

  final categories = [
    "Semua",
    "Kajian Rutin",
    "Spesial Acara",
    "Agenda Spesial",
    "Tematik Pilihan",
  ];

  final allCertificates = [
    {
      "masjid": "Masjid At–Taqwa Cibubur",
      "kategori": "Kajian Rutin",
      "nilai": 80,
      "materi": "Keimanan - Level 1",
      "tanggal": "3 November 2025",
    },
    {
      "masjid": "Masjid Nurul Iman",
      "kategori": "Spesial Acara",
      "nilai": 90,
      "materi": "Aqidah - Level 2",
      "tanggal": "10 November 2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered =
        selectedIndex == 0
            ? allCertificates
            : allCertificates
                .where((e) => e['kategori'] == categories[selectedIndex])
                .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sertifikat"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _CategoryFilterBar(
              categories: categories,
              selectedIndex: selectedIndex,
              onChanged: (i) => setState(() => selectedIndex = i),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final item = filtered[index] as Map<String, dynamic>;
                  return CertificateCard(
                    masjid: item['masjid']!,
                    nilai: item['nilai']!,
                    materi: item['materi']!,
                    tanggal: item['tanggal']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryFilterBar extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _CategoryFilterBar({
    required this.categories,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (i) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(categories[i]),
              selected: selectedIndex == i,
              onSelected: (_) => onChanged(i),
              selectedColor: const Color(0xFFE0F2F1),
            ),
          ),
        ),
      ),
    );
  }
}

class CertificateCard extends StatelessWidget {
  final String masjid;
  final int nilai;
  final String materi;
  final String tanggal;

  const CertificateCard({
    super.key,
    required this.masjid,
    required this.nilai,
    required this.materi,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    masjid,
                    style: const TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text("🧾 Nilai : $nilai"),
              ],
            ),
            const SizedBox(height: 4),
            Text(materi),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.circle, size: 10),
                const SizedBox(width: 6),
                Text("Lulus : $tanggal"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                TextButton(onPressed: () {}, child: const Text("Selengkapnya")),
                const Spacer(),
                IconButton(icon: const Icon(Icons.download), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
