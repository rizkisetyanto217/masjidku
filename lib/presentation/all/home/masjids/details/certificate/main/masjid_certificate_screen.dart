import 'package:flutter/material.dart';

class CertificateMasjidScreen extends StatefulWidget {
  const CertificateMasjidScreen({super.key});

  @override
  State<CertificateMasjidScreen> createState() =>
      _CertificateMasjidScreenState();
}

class _CertificateMasjidScreenState extends State<CertificateMasjidScreen> {
  int selectedCategory = 0;

  final List<String> categories = [
    "Semua",
    "Kajian Rutin",
    "Spesial Acara",
    "Agenda Spesial",
    "Tematik Pilihan",
  ];

  final List<Map<String, dynamic>> certificateItems = [
    {
      "masjid": "Masjid At–Taqwa Cibubur",
      "kajian": "Keimanan – Level 1",
      "lulus": "3 November 2025",
      "nilai": 80,
      "category": "Kajian Rutin",
    },
    {
      "masjid": "Masjid Al-Hikmah",
      "kajian": "Fiqih – Level 2",
      "lulus": "7 Oktober 2025",
      "nilai": 75,
      "category": "Spesial Acara",
    },
    {
      "masjid": "Masjid An-Nur",
      "kajian": "Aqidah – Level 1",
      "lulus": "21 September 2025",
      "nilai": 90,
      "category": "Agenda Spesial",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategory == 0) return certificateItems;
    return certificateItems
        .where((item) => item['category'] == categories[selectedCategory])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontal tab filter
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  final isSelected = selectedCategory == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(categories[index]),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() => selectedCategory = index);
                      },
                      selectedColor: const Color(0xFFB2DFDB),
                      backgroundColor: Colors.grey.shade200,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.black : Colors.black87,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),

            // List of certificate cards
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (_, index) {
                  final item = filteredItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _CertificateCard(
                      masjid: item['masjid'],
                      kajian: item['kajian'],
                      lulus: item['lulus'],
                      nilai: item['nilai'],
                    ),
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

class _CertificateCard extends StatelessWidget {
  final String masjid;
  final String kajian;
  final String lulus;
  final int nilai;

  const _CertificateCard({
    required this.masjid,
    required this.kajian,
    required this.lulus,
    required this.nilai,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFB2DFDB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Masjid + Nilai
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                masjid,
                style: const TextStyle(
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                "📜 Nilai : $nilai",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  // color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(kajian, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.circle, size: 8),
              const SizedBox(width: 6),
              Text(
                "Lulus : $lulus",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Selengkapnya",
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(Icons.download, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}