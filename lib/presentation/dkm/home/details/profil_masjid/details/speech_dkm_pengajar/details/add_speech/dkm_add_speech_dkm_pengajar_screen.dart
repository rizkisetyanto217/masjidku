import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:masjidku/component/main/button/main_button.dart';

class DkmAddSpeechDkmPengajarScreen extends StatefulWidget {
  const DkmAddSpeechDkmPengajarScreen({super.key});

  @override
  State<DkmAddSpeechDkmPengajarScreen> createState() =>
      _DkmAddSpeechDkmPengajarScreenState();
}

class _DkmAddSpeechDkmPengajarScreenState
    extends State<DkmAddSpeechDkmPengajarScreen> {
  final quill.QuillController _controller = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _saveSpeech() {
    final delta = _controller.document.toDelta();
    final json = delta.toJson();
    debugPrint("Saved speech content: $json");

    // TODO: Simpan ke database atau state
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Sambutan"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 12)],
      ),
      body: Column(
        children: [
          quill.QuillSimpleToolbar(
            controller: _controller,
            config: const quill.QuillSimpleToolbarConfig(),
          ),
          const Divider(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: quill.QuillEditor(
                controller: _controller,
                focusNode: _focusNode,
                scrollController: ScrollController(),
                config: const quill.QuillEditorConfig(
                  expands: true,
                  autoFocus: false,
                  scrollable: true,
                  padding: EdgeInsets.all(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MainButton(
              label: "Simpan Perubahan",
              onPressed: _saveSpeech,
            ),
          ),
        ],
      ),
    );
  }
}
