import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/presentation/all/home/donation/details/search_masjid/cubit/selected_masjid_cubit.dart';

class DonationSearchMasjidScreen extends StatefulWidget {
  const DonationSearchMasjidScreen({super.key});

  @override
  State<DonationSearchMasjidScreen> createState() =>
      _DonationSearchMasjidScreenState();
}

class _DonationSearchMasjidScreenState
    extends State<DonationSearchMasjidScreen> {
  final TextEditingController _searchController = TextEditingController();
  int selectedTab = 0;
  Map<String, String>? selectedMasjid;

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
        sourceList.where((masjid) {
          return masjid["name"]!.toLowerCase().contains(query) ||
              masjid["location"]!.toLowerCase().contains(query);
        }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text("Cari Masjid"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSearchField(),
            const SizedBox(height: 16),
            _buildTabChips(),
            const SizedBox(height: 16),
            Expanded(child: _buildMasjidList(filteredMasjid)),
            const SizedBox(height: 12),
            _buildLanjutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText:
            selectedTab == 0 ? "Cari semua masjid" : "Cari masjid yang diikuti",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildTabChips() {
    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = selectedTab == index;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(tabs[index]),
            selected: isSelected,
            selectedColor: const Color(0xFF006B64),
            labelStyle: TextStyle(color: Colors.white),
            onSelected: (_) {
              setState(() {
                selectedTab = index;
                selectedMasjid = null; // Reset selected masjid on tab change
              });
            },
          ),
        );
      }),
    );
  }

  Widget _buildMasjidList(List<Map<String, String>> masjids) {
    if (masjids.isEmpty) {
      return const Center(child: Text("Tidak ditemukan."));
    }

    return ListView.builder(
      itemCount: masjids.length,
      itemBuilder: (context, index) {
        final masjid = masjids[index];
        final isSelected = selectedMasjid == masjid;

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
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
            style:
                isSelected
                    ? const TextStyle(color: Colors.black)
                    : const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            masjid["location"]!,
            style:
                isSelected
                    ? const TextStyle(color: Colors.black)
                    : const TextStyle(color: Colors.white),
          ),
          tileColor: isSelected ? const Color(0xFFE0F2F1) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: () {
            setState(() {
              selectedMasjid = masjid;
            });
          },
        );
      },
    );
  }

  Widget _buildLanjutButton() {
    final isEnabled = selectedMasjid != null;

    return SizedBox(
      width: double.infinity,
      child: MainButton(
        onPressed:
            isEnabled
                ? () {
                  context.read<SelectedMasjidCubit>().selectMasjid(
                    selectedMasjid!,
                  );
                  context.go('/donation'); // ⬅️ navigasi langsung
                }
                : null,
        label: "Lanjut",
        backgroundColor: isEnabled ? const Color(0xFF006B64) : Colors.grey,
      ),
    );
  }
}
