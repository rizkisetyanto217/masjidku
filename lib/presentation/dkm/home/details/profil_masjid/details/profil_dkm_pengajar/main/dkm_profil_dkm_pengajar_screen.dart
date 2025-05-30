import 'package:flutter/material.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/home/tab_switch_component.dart';

class DkmProfilDkmPengajarScreen extends StatefulWidget {
  const DkmProfilDkmPengajarScreen({super.key});

  @override
  State<DkmProfilDkmPengajarScreen> createState() =>
      _DkmProfilDkmPengajarScreenState();
}

class _DkmProfilDkmPengajarScreenState
    extends State<DkmProfilDkmPengajarScreen> {
  String selectedTab = 'Pengajar';

  final pengajarList = [
    {'label': 'Pengajar Kajian Rutin Fiqh', 'value': 'Ustadz Firza, Lc'},
    {'label': 'Pengajar Kajian Tematik', 'value': 'Ustadz Muhammad Yassir'},
    {'label': 'Pengajar Kajian Aqidah', 'value': 'Ustadz Taufiq'},
    {'label': 'Pengajar Kajian Sejarah', 'value': 'Bapak Husain'},
  ];

  final strukturList = [
    {'label': 'Ketua DKM', 'value': 'Ustadz Firza, Lc'},
    {'label': 'Ketua Pelaksana', 'value': 'Ustadz Muhammad Yassir'},
    {'label': 'Sekretaris', 'value': 'Ustadz Taufiq'},
    {'label': 'Bendahara', 'value': 'Bapak Husain'},
  ];

  @override
  Widget build(BuildContext context) {
    final isPengajar = selectedTab == 'Pengajar';
    final listData = isPengajar ? pengajarList : strukturList;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil DKM dan Pengajar"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 12)],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabSwitch(
              tabs: const ['Pengajar', 'Pengurus DKM'],
              selectedTab: selectedTab,
              onChanged: (label) => setState(() => selectedTab = label),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: listData.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = listData[index];
                return ListTile(
                  title: Text(item['label']!),
                  subtitle: Text(item['value']!),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {}, // TODO: Navigate to detail/edit
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MainButton(
              label: isPengajar ? "Tambah Pengajar" : "Tambah Pengurus DKM",
              onPressed: () {
                // TODO: Aksi tambah
              },
            ),
          ),
        ],
      ),
    );
  }
}
