import 'package:flutter/material.dart';
import 'package:masjidku/component/main/information/information_filter_tabs.dart';
import 'package:masjidku/component/main/information/information_post_list.dart';

class InformasiScreeen extends StatefulWidget {
  const InformasiScreeen({super.key});

  @override
  State<InformasiScreeen> createState() => _InformasiScreeenState();
}

class _InformasiScreeenState extends State<InformasiScreeen> {
  final List<Map<String, String>> posts = [
    {
      'category': 'Informasi',
      'time': '1 hari yang lalu',
      'title':
          'Quiz app sudah memiliki 10 materi baru pada pelajaran Aqidah akhlak. Bersiaplah dari sekarang....',
      'content':
          'Hari ini kajian bersama ustadz Abdul Somad. Silakan datang pukul 09.00 WIB. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
    },
    {
      'category': 'Peringatan',
      'time': '1 jam yang lalu',
      'title': 'Hari ini kajian ustadz abdul somad',
    },
    {
      'category': 'Kajian Rutin',
      'time': '2 hari yang lalu',
      'title': 'Kajian tafsir pagi bersama ust. Khalid Basalamah.',
    },
    {
      'category': 'Spesial Acara',
      'time': '3 hari yang lalu',
      'title':
          'Acara buka bersama dan santunan anak yatim. Yuk ikut berdonasi!',
    },
    {
      'category': 'Peringatan',
      'time': '1 jam yang lalu',
      'title':
          'Mulai 12 agustus 2025. Quiz app akan melaksanakan program khusus menyambut hari raya Idul Adha. Bersiaplah dari sekarang....',
    },
  ];

  late final List<String> categories;
  int selectedFilterIndex = 0;

  @override
  void initState() {
    super.initState();
    categories =
        posts
            .map((post) => post['category']!)
            .toSet()
            .toList(); // Unique categories from data
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = categories[selectedFilterIndex];
    final filteredPosts =
        posts.where((post) => post['category'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Informasi"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          InformationFilterTabs(
            categories: categories,
            selectedIndex: selectedFilterIndex,
            onSelected: (i) => setState(() => selectedFilterIndex = i),
          ),
          InformationPostList(data: filteredPosts),
        ],
      ),
    );
  }
}
