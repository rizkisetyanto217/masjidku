import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/presentation/all/home/search/cubit/masjid_cubit.dart';
import 'package:masjidku/presentation/all/home/search/model/masjid_model.dart';
import 'package:masjidku/presentation/all/home/search/widget/masjid_list_section.dart';

class SearchMasjidScreen extends StatefulWidget {
  const SearchMasjidScreen({super.key});

  @override
  State<SearchMasjidScreen> createState() => _SearchMasjidScreenState();
}

class _SearchMasjidScreenState extends State<SearchMasjidScreen> {
  final TextEditingController _searchController = TextEditingController();
  int selectedTab = 0;

  final List<String> tabs = ["Cari Masjid", "Masjid Saya"];

  final List<MasjidModel> myMasjid = [
    MasjidModel(
      masjidName: "Masjid Jami’ At Taqwa",
      masjidLocation: "Ciracas, Jakarta Timur",
      masjidImage: "assets/images/image-masjid.png",
      masjidSlug: "Masjid-Jami-At-Taqwa",
    ),
  ];

  @override
  void initState() {
    super.initState();
    context.read<MasjidCubit>().fetchMasjids();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final String query = _searchController.text.toLowerCase();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Cari Masjid"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
            Row(
              children: List.generate(tabs.length, (index) {
                final isSelected = selectedTab == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      tabs[index],
                      style: TextStyle(
                        color:
                            isSelected
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: colorScheme.primary,
                    backgroundColor: colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color:
                          isSelected
                              ? colorScheme.primary
                              : colorScheme.outline.withOpacity(0.5),
                    ),
                    onSelected: (_) {
                      setState(() => selectedTab = index);
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: MasjidListSection(
                selectedTab: selectedTab,
                query: query,
                myMasjid: myMasjid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
