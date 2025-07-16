import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class DkmAddFileStudyScreen extends StatefulWidget {
  const DkmAddFileStudyScreen({super.key});

  @override
  State<DkmAddFileStudyScreen> createState() => _DkmAddFileStudyScreenState();
}

class _DkmAddFileStudyScreenState extends State<DkmAddFileStudyScreen> {
  final TextEditingController youtubeLinkController = TextEditingController();
  File? selectedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4', 'mov'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });

      // TODO: Upload logic goes here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Materi Kajian Upload"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilihan dalam upload data kajian (pilih salah satu)",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              "1. Link Kajian dari Youtube",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
            ),
            const SizedBox(height: 4),
            const Text("Masukkan link pada kotak dibawah ini"),
            const SizedBox(height: 8),
            TextField(
              controller: youtubeLinkController,
              decoration: InputDecoration(
                hintText: "Link Youtube",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "2. Kajian berbentuk video, audio",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
            ),
            const SizedBox(height: 4),
            const Text("File yang diizinkan berbentuk MP3 dan Video"),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                ),
                child: Center(
                  child:
                      selectedFile == null
                          ? const Text(
                            "Click to browse or\ndrag and drop your files",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          )
                          : Text(
                            "Selected: ${selectedFile!.path.split('/').last}",
                            style: const TextStyle(color: Colors.black87),
                          ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Akan dibuatkan hasil transkrip teks, kesimpulan dan soal latihan secara otomatis.",
              style: TextStyle(fontSize: 13),
            ),
            const Spacer(),
            MainButton(
              label: "Kirim",
              onPressed: () {
                context.go('/dkm/study/add-study-confirm');
                debugPrint("Link Youtube: ${youtubeLinkController.text}");
                debugPrint("File: ${selectedFile?.path}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
