import 'package:flutter/material.dart';

class StudyTranscriptionScreen extends StatefulWidget {
  const StudyTranscriptionScreen({super.key});

  @override
  State<StudyTranscriptionScreen> createState() =>
      _StudyTranscriptionScreenState();
}

class _StudyTranscriptionScreenState extends State<StudyTranscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transkrip Pembelajaran"),
        leading: const BackButton(),
      ),
    );
  }
}
