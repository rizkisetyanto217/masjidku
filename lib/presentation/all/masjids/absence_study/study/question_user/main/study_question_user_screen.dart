import 'package:flutter/material.dart';

class StudyQuestionUserScreen extends StatefulWidget {
  const StudyQuestionUserScreen({super.key});

  @override
  State<StudyQuestionUserScreen> createState() =>
      _StudyQuestionUserScreenState();
}

class _StudyQuestionUserScreenState extends State<StudyQuestionUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pertanyaan Peserta Pembelajaran"),
        leading: const BackButton(),
      ),
    );
  }
}
