import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  String selectedFilter = "Semua";

  final List<FaqItem> allFaqItems = [
    FaqItem(
      question: "Bagi pemula tingkat mana yang sebaiknya dipilih ?",
      answer:
          "Disarankan memilih tingkatan dasar untuk membangun pondasi ilmu.",
      category: "Umum",
    ),
    FaqItem(
      question: "Apakah pemula bisa mengikuti kelas penuntut ilmu ?",
      answer: "Bisa, namun lebih baik memulai dari tingkatan pengantar.",
      category: "Pembelajaran",
    ),
    FaqItem(
      question:
          "Jika sudah memilih salah satu tingkatan. Apakah bisa memilih lagi ?",
      answer: "Ya, pengguna bisa memilih ulang sesuai kebutuhan dan kemampuan.",
      category: "Umum",
    ),
    FaqItem(
      question: "Apakah ada materi berita dalam aplikasi ini?",
      answer: "Ada. Kami menyediakan ringkasan berita islami terpercaya.",
      category: "Berita",
    ),
    FaqItem(
      question: "Apakah ada kelas tematik khusus seperti parenting?",
      answer:
          "Ya, tersedia pada kategori Tematik Pilihan seperti keluarga dan parenting.",
      category: "Tematik Pilihan",
    ),
    FaqItem(
      question: "Bagaimana cara menandai pelajaran yang sudah selesai?",
      answer:
          "Pelajaran yang sudah selesai akan otomatis tercentang oleh sistem.",
      category: "Pembelajaran",
    ),
    FaqItem(
      question: "Apakah bisa belajar tanpa login?",
      answer:
          "Untuk akses penuh termasuk evaluasi dan progres, login diperlukan.",
      category: "Umum",
    ),
    FaqItem(
      question: "Dari mana sumber materi pembelajaran diambil?",
      answer: "Materi diambil dari kitab-kitab terpercaya dan ustadz rujukan.",
      category: "Pembelajaran",
    ),
    FaqItem(
      question: "Apakah ada fitur bookmark atau simpan materi?",
      answer: "Ya, pengguna bisa menyimpan materi favorit untuk dibaca ulang.",
      category: "Umum",
    ),
  ];

  List<String> filters = [
    "Semua",
    "Umum",
    "Berita",
    "Pembelajaran",
    "Tematik Pilihan",
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFaqs =
        selectedFilter == "Semua"
            ? allFaqItems
            : allFaqItems
                .where((item) => item.category == selectedFilter)
                .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tanya Jawab"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildFilterChips(),
            const SizedBox(height: 16),
            Expanded(child: _buildFaqList(filteredFaqs)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            filters.map((label) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(label),
                  selected: label == selectedFilter,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedFilter = label;
                    });
                  },
                  showCheckmark: false,
                  selectedColor: Colors.green[100],
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildFaqList(List<FaqItem> faqItems) {
    return ListView.separated(
      itemCount: faqItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildFaqTile(faqItems[index]);
      },
    );
  }

  Widget _buildFaqTile(FaqItem faq) {
    return ExpansionTile(
      title: Text(
        faq.question,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
          child: Text(faq.answer),
        ),
      ],
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFFD0D5DD)),
        borderRadius: BorderRadius.circular(12),
      ),
      collapsedShape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFFD0D5DD)),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;
  final String category;

  FaqItem({
    required this.question,
    required this.answer,
    required this.category,
  });
}
