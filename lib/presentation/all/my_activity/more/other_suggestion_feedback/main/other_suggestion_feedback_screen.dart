import 'package:flutter/material.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/home/tab_switch_component.dart';

class SuggestionFeedbackScreen extends StatefulWidget {
  const SuggestionFeedbackScreen({super.key});

  @override
  State<SuggestionFeedbackScreen> createState() =>
      _SuggestionFeedbackScreenState();
}

class _SuggestionFeedbackScreenState extends State<SuggestionFeedbackScreen> {
  String _selectedTab = 'Saran';
  String? _selectedOption;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSaran = _selectedTab == 'Saran';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saran dan Masukan"),
        leading: const BackButton(),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabSwitch(
              tabs: const ['Saran', 'Masukan'],
              selectedTab: _selectedTab,
              onChanged: (label) {
                setState(() {
                  _selectedTab = label;
                });
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isSaran
                        ? "Pendapat yang berupa ide, rekomendasi atau langkah kedepan. Contohnya penambahan fitur atau materi tertentu."
                        : "Pendapat yang diberikan sebagai tanggapan berdasarkan pengalaman penggunaan. Contohnya kritik maupun penilaian.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _textController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Tulis disini",
                      filled: true,
                      fillColor:
                          isDark ? Colors.grey[800] : const Color(0xFFF8F8F8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDark
                                  ? Colors.grey.shade700
                                  : const Color(0xFFDDDDDD),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDark
                                  ? Colors.grey.shade700
                                  : const Color(0xFFDDDDDD),
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Bolehkah kami menghubungi anda untuk tindakan lebih lanjut",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  CheckboxListTile(
                    title: const Text("Boleh"),
                    value: _selectedOption == "boleh",
                    onChanged: (_) {
                      setState(() => _selectedOption = "boleh");
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                  CheckboxListTile(
                    title: const Text("Maaf, belum bisa"),
                    value: _selectedOption == "tidak",
                    onChanged: (_) {
                      setState(() => _selectedOption = "tidak");
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: MainButton(
          label: "Kirim",
          onPressed: () {
            // TODO: Kirim ke backend / tampilkan notifikasi
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Terima kasih atas masukannya!")),
            );
          },
        ),
      ),
    );
  }
}
