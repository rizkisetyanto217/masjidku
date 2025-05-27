import 'package:flutter/material.dart';

class MateriKajianUploadPage extends StatefulWidget {
  const MateriKajianUploadPage({Key? key}) : super(key: key);

  @override
  _MateriKajianUploadPageState createState() => _MateriKajianUploadPageState();
}

class _MateriKajianUploadPageState extends State<MateriKajianUploadPage> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController pengajarController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();

  String? selectedKategori;
  String? selectedSubKategori;

  final List<String> kategoriList = ['Fiqh', 'Aqidah', 'Hadits'];
  final List<String> subKategoriList = ['Wudhu', 'Shalat', 'Zakat'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Publikasi Materi Kajian')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel('Judul Kajian'),
            TextField(
              controller: judulController,
              decoration: const InputDecoration(
                hintText: 'Judul Kajian',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            buildLabel('Kategori'),
            DropdownButtonFormField<String>(
              value: selectedKategori,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text('Pilih Kategori'),
              items:
                  kategoriList.map((kategori) {
                    return DropdownMenuItem(
                      value: kategori,
                      child: Text(kategori),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() => selectedKategori = value);
              },
            ),
            const SizedBox(height: 16),

            buildLabel('Sub Kategori'),
            DropdownButtonFormField<String>(
              value: selectedSubKategori,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text('Pilih Sub Kategori'),
              items:
                  subKategoriList.map((sub) {
                    return DropdownMenuItem(value: sub, child: Text(sub));
                  }).toList(),
              onChanged: (value) {
                setState(() => selectedSubKategori = value);
              },
            ),
            const SizedBox(height: 16),

            buildLabel('Deskripsi Kajian'),
            TextField(
              controller: deskripsiController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Deskripsi Kajian',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            buildLabel('Pengajar'),
            TextField(
              controller: pengajarController,
              decoration: const InputDecoration(
                hintText: 'Nama Pengajar',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            buildLabel('Tanggal'),
            GestureDetector(
              onTap: _selectDateTime,
              child: AbsorbPointer(
                child: TextField(
                  controller: tanggalController,
                  decoration: const InputDecoration(
                    hintText: 'Pilih Tanggal & Jam',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Simpan data atau validasi di sini
                  print("Judul: ${judulController.text}");
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.teal[700],
                ),
                child: const Text('Kirim', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime combined = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final formatted =
            "${combined.day.toString().padLeft(2, '0')}-"
            "${combined.month.toString().padLeft(2, '0')}-"
            "${combined.year} ${pickedTime.format(context)}";

        setState(() {
          tanggalController.text = formatted;
        });
      }
    }
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.teal,
        ),
      ),
    );
  }
}
