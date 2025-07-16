import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class DkmCreatePostScreen extends StatefulWidget {
  const DkmCreatePostScreen({super.key});

  @override
  State<DkmCreatePostScreen> createState() => _DkmCreatePostScreenState();
}

class _DkmCreatePostScreenState extends State<DkmCreatePostScreen> {
  final quill.QuillController _controller = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final List<String> _kategori = ['Informasi kajian', 'Nasehat', 'Umum'];
  String? _selectedKategori;
  File? _imageFile;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _submitPost() {
    final delta = _controller.document.toDelta();
    final json = delta.toJson();
    debugPrint("Kategori: $_selectedKategori");
    debugPrint("Konten: $json");
    debugPrint("Gambar: ${_imageFile?.path}");

    // TODO: Kirim ke backend
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Postingan"),
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
          quill.QuillSimpleToolbar(
            controller: _controller,
            config: const quill.QuillSimpleToolbarConfig(),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEditor(),
                  const SizedBox(height: 16),
                  _buildDropdownKategori(),
                  const SizedBox(height: 16),
                  _buildImagePicker(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MainButton(label: "Kirim", onPressed: _submitPost),
          ),
        ],
      ),
    );
  }

  Widget _buildEditor() {
    return Container(
      constraints: const BoxConstraints(minHeight: 200), // atau 250 / 300
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: quill.QuillEditor.basic(
        controller: _controller,
        focusNode: _focusNode,
        // readOnly: false,
      ),
    );
  }

  Widget _buildDropdownKategori() {
    return DropdownButtonFormField<String>(
      value: _selectedKategori,
      hint: const Text("Pilih Kategori"),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      items:
          _kategori
              .map((k) => DropdownMenuItem(value: k, child: Text(k)))
              .toList(),
      onChanged: (val) => setState(() => _selectedKategori = val),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child:
          _imageFile != null
              ? AspectRatio(
                aspectRatio: 3 / 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              )
              : Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Icon(Icons.image, size: 40)),
              ),
    );
  }
}
