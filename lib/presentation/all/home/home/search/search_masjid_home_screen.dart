import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchMasjidScreen extends StatefulWidget {
  const SearchMasjidScreen({super.key});

  @override
  State<SearchMasjidScreen> createState() => _SearchMasjidScreenState();
}

class _SearchMasjidScreenState extends State<SearchMasjidScreen> {
  final TextEditingController _searchController = TextEditingController();
  int selectedTab = 0;

  final List<String> tabs = ["Cari Masjid", "Masjid Saya"];

  final List<Map<String, String>> allMasjid = [
    {
      "name": "Masjid Jami’ At Taqwa Cibubur",
      "location": "Tanah Abang, Jakarta Pusat",
      "image": "assets/images/image-masjid.png",
    },
    {
      "name": "Masjid Jami’ At Taqwa",
      "location": "Ciracas, Jakarta Timur",
      "image": "assets/images/image-masjid.png",
    },
    {
      "name": "Masjid Agung Al Azhar",
      "location": "Kebayoran Baru, Jakarta Selatan",
      "image": "assets/images/image-masjid.png",
    },
  ];

  final List<Map<String, String>> myMasjid = [
    {
      "name": "Masjid Jami’ At Taqwa",
      "location": "Ciracas, Jakarta Timur",
      "image": "assets/images/image-masjid.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final String query = _searchController.text.toLowerCase();

    final List<Map<String, String>> sourceList =
        selectedTab == 0 ? allMasjid : myMasjid;

    final filteredMasjid =
        sourceList
            .where(
              (masjid) =>
                  masjid["name"]!.toLowerCase().contains(query) ||
                  masjid["location"]!.toLowerCase().contains(query),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              () => context.go('/home'), // ⬅️ kembali ke halaman sebelumnya
        ),
        title: const Text("Cari Masjid"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔍 Search Input
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText:
                    selectedTab == 0
                        ? "Cari semua masjid"
                        : "Cari masjid yang diikuti",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🔘 Filter Tabs
            Row(
              children: List.generate(tabs.length, (index) {
                final isSelected = selectedTab == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(tabs[index]),
                    selected: isSelected,
                    selectedColor: const Color(0xFF006B64),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white,
                    ),
                    onSelected: (_) {
                      setState(() => selectedTab = index);
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            // 📋 List of Masjid
            Expanded(
              child:
                  filteredMasjid.isEmpty
                      ? const Center(child: Text("Tidak ditemukan."))
                      : ListView.builder(
                        itemCount: filteredMasjid.length,
                        itemBuilder: (context, index) {
                          final masjid = filteredMasjid[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                masjid["image"]!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              masjid["name"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(masjid["location"]!),
                            onTap: () {
                              context.go('/masjid');
                            },
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
