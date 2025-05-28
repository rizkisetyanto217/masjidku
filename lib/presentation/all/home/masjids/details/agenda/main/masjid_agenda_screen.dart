import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/core/constants/app_spacing.dart';

class AgendaMasjidScreen extends StatefulWidget {
  const AgendaMasjidScreen({super.key});

  @override
  State<AgendaMasjidScreen> createState() => _AgendaMasjidScreenState();
}

class _AgendaMasjidScreenState extends State<AgendaMasjidScreen> {
  final List<String> filters = [
    "Semua",
    "Kajian Rutin",
    "Spesial Acara",
    "Agenda Spesial",
    "Tematik Pilihan",
  ];

  int selectedIndex = 0;

  final List<Map<String, String>> allAgendaItems = [
    {
      'title': 'Fiqh Syafi’i',
      'subtitle': 'Bab 5 - Wudhu dengan sempurna',
      'ustadz': 'Ustadz Budi Hariadi',
      'waktu': 'Tiap sabtu pukul 20.00 WIB',
      'kategori': 'Kajian Rutin',
    },
    {
      'title': 'Khutbah Jum’at',
      'subtitle': '',
      'ustadz': 'Ustadz Budi Hariadi',
      'waktu': 'Tiap sabtu pukul 20.00 WIB',
      'kategori': 'Spesial Acara',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter agenda sesuai index yang dipilih
    final filteredItems =
        selectedIndex == 0
            ? allAgendaItems
            : allAgendaItems
                .where((item) => item['kategori'] == filters[selectedIndex])
                .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          AppSpacing.sm,
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          _buildFilterChips(),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return InkWell(
                  onTap:
                      () => GoRouter.of(
                        context,
                      ).push('/masjid/agenda/detail', extra: item),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006B64),
                          ),
                        ),
                        if (item['subtitle']!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(item['subtitle']!),
                        ],
                        const SizedBox(height: 4),
                        Text(item['ustadz']!),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.circle, size: 8),
                            const SizedBox(width: 6),
                            Text(item['waktu']!),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return ChoiceChip(
            label: Text(filters[index]),
            selected: isSelected,
            selectedColor: const Color(0xFF006B64),
            onSelected: (_) => setState(() => selectedIndex = index),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
            backgroundColor: Colors.grey[200],
          );
        },
      ),
    );
  }
}