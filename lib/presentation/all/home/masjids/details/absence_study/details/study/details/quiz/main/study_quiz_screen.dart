import 'package:flutter/material.dart';

class StudyQuizScreen extends StatefulWidget {
  const StudyQuizScreen({super.key});

  @override
  State<StudyQuizScreen> createState() => _StudyQuizScreenState();
}

class _StudyQuizScreenState extends State<StudyQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Pembelajaran"),
        leading: const BackButton(),
      ),
    );
  }
}
