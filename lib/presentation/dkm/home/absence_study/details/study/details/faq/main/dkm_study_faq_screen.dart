import 'package:flutter/material.dart';

class DkmStudyFaqScreen extends StatefulWidget {
  const DkmStudyFaqScreen({super.key});

  @override
  State<DkmStudyFaqScreen> createState() => _DkmStudyFaqScreenState();
}

class _DkmStudyFaqScreenState extends State<DkmStudyFaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FAQ"), leading: const BackButton()),
    );
  }
}
