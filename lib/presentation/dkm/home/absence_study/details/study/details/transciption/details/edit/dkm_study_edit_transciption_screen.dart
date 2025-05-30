import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:masjidku/component/main/button/main_button.dart';

class DkmStudyEditTransciptionScreen extends StatefulWidget {
  const DkmStudyEditTransciptionScreen({super.key});

  @override
  State<DkmStudyEditTransciptionScreen> createState() =>
      _DkmStudyEditTransciptionScreenState();
}

class _DkmStudyEditTransciptionScreenState extends State<DkmStudyEditTransciptionScreen> {
  final quill.QuillController _controller = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  @override

  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _saveNotification() {
    final contentDelta = _controller.document.toDelta();
    final jsonData = contentDelta.toJson();

    debugPrint("📝 Notifikasi disimpan: $jsonData");

    // TODO: Simpan ke backend
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Notifikasi"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 12)],
      ),
      body: Column(
        children: [
          quill.QuillSimpleToolbar(
            controller: _controller,
            config: const quill.QuillSimpleToolbarConfig(
              showAlignmentButtons: false,
              showCodeBlock: false,
              showHeaderStyle: true,
            ),
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
                  padding: EdgeInsets.all(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MainButton(
              label: "Kirim Notifikasi",
              onPressed: _saveNotification,
            ),
          ),
        ],
      ),
    );
  }
}
