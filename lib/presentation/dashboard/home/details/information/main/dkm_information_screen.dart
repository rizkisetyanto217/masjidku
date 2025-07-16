import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/information/information_filter_tabs.dart';
import 'package:masjidku/component/main/information/information_post_list.dart';

class DkmInformationScreen extends StatefulWidget {
  const DkmInformationScreen({super.key});

  @override
  State<DkmInformationScreen> createState() => _DkmInformationScreenState();
}

class _DkmInformationScreenState extends State<DkmInformationScreen> {
  final List<Map<String, String>> notifications = [
    {
      'category': 'Informasi',
      'time': '1 hari yang lalu',
      'title':
          'Quiz app sudah memiliki 10 materi baru pada pelajaran Aqidah akhlak. Bersiaplah dari sekarang....',
      'content':
          'Hari ini kajian bersama ustadz Abdul Somad. Silakan datang pukul 09.00 WIB. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s...',
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
    categories = notifications.map((n) => n['category']!).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = categories[selectedFilterIndex];
    final filteredNotifications =
        notifications.where((n) => n['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          InformationFilterTabs(
            categories: categories,
            selectedIndex: selectedFilterIndex,
            onSelected: (i) => setState(() => selectedFilterIndex = i),
          ),
          InformationPostList(data: filteredNotifications),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: MainButton(
              label: "Tambah Informasi",
              onPressed: () {
                context.go('/dkm/information/add-information');
              },
            ),
          ),
        ],
      ),
    );
  }
}