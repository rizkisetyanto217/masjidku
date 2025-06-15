import 'package:flutter/material.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class DetailThemaStudySuggestionUserScreen extends StatefulWidget {
  const DetailThemaStudySuggestionUserScreen({super.key});

  @override
  State<DetailThemaStudySuggestionUserScreen> createState() =>
      _DetailThemaStudySuggestionUserScreenState();
}

class _DetailThemaStudySuggestionUserScreenState
    extends State<DetailThemaStudySuggestionUserScreen> {
  final TextEditingController _textController = TextEditingController();
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saran Peserta"),
        leading: const BackButton(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pendapat yang berupa ide, rekomendasi atau langkah kedepan. Contohnya penambahan fitur atau materi tertentu.",
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Tulis disini",
                filled: true,
                // fillColor: const Color(0xFFF8F8F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                ),
                contentPadding: const EdgeInsets.all(12),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: MainButton(
          label: "Kirim",
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Terima kasih atas saran Anda!")),
            );
          },
        ),
      ),
    );
  }
}
