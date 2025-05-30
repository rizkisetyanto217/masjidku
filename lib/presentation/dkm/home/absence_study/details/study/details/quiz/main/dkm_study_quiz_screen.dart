import 'package:flutter/material.dart';

class DkmStudyQuizScreen extends StatefulWidget {
  const DkmStudyQuizScreen({super.key});

  @override
  State<DkmStudyQuizScreen> createState() => _DkmStudyQuizScreenState();
}

class _DkmStudyQuizScreenState extends State<DkmStudyQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz"), leading: const BackButton()),
    );
  }
}
