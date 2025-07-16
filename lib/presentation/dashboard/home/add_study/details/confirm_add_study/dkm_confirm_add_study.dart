import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class DkmConfirmAddStudy extends StatefulWidget {
  const DkmConfirmAddStudy({super.key});

  @override
  State<DkmConfirmAddStudy> createState() => _DkmConfirmAddStudyState();
}
class _DkmConfirmAddStudyState extends State<DkmConfirmAddStudy> {
  int selectedIndex = -1; // ⬅️ Default tidak ada yang dipilih

  final List<Map<String, dynamic>> options = [
    {
      "title": "Standard – Rp. 15.000",
      "subtitle": "Otomatis oleh sistem Masjidku",
      "benefits": ["Ringkasan transkrip teks.", "10 soal latihan."],
      "highlight": false,
    },
    {
      "title": "📖 Menengah – Rp. 30.000",
      "subtitle": "Melibatkan pemeriksaan dari Ustadz Masjidku",
      "benefits": [
        "Semua di standard",
        "Transkip teks lengkap dari Youtube/MP3.",
        "20 soal latihan",
      ],
      "highlight": false,
    },
    {
      "title": "🌟 Terbaik – Rp. 50.000",
      "subtitle":
          "Dioptimalkan dengan pemeriksaan mendalam dari Ustadz Masjidku.",
      "benefits": ["Semua di Menengah", "40 soal latihan"],
      "highlight": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konfirmasi Materi Upload"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 8)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...List.generate(options.length, (index) {
              final item = options[index];
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => setState(() => selectedIndex = index),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.teal : Colors.grey.shade300,
                      width: isSelected ? 1.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:
                        item["highlight"]
                            ? [
                              BoxShadow(
                                color: Colors.teal.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ]
                            : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item["title"],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (item["highlight"])
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.teal.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                "Rekomendasi",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          Radio<int>(
                            value: index,
                            groupValue: selectedIndex,
                            onChanged:
                                (val) => setState(() => selectedIndex = val!),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item["subtitle"],
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(
                        item["benefits"].length,
                        (i) => Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Colors.teal,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                item["benefits"][i],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const Spacer(),
            MainButton(
              label: "Selanjutnya",
              onPressed:
                  selectedIndex == -1
                      ? null
                      : () {
                        context.go('/dkm/confirm-add-study');
                      },
            ),
          ],
        ),
      ),
    );
  }
}
