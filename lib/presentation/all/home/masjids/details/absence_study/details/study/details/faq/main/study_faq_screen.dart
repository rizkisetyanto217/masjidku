import 'package:flutter/material.dart';

class StudyFaqScreen extends StatefulWidget {
  const StudyFaqScreen({super.key});

  @override
  State<StudyFaqScreen> createState() => _StudyFaqScreenState();
}

class _StudyFaqScreenState extends State<StudyFaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FAQ"), leading: const BackButton()),
    );
  }
}
