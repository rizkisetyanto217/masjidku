import 'package:flutter/material.dart';

class DetailThemaStudyNoteUserScreen extends StatefulWidget {
  const DetailThemaStudyNoteUserScreen({super.key});

  @override
  State<DetailThemaStudyNoteUserScreen> createState() =>
      _DetailThemaStudyNoteUserScreenState();
}

class _DetailThemaStudyNoteUserScreenState extends State<DetailThemaStudyNoteUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catatan Peserta"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
