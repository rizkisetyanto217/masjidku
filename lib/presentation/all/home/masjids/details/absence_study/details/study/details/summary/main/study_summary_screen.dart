import 'package:flutter/material.dart';

class StudySummaryScreen extends StatefulWidget {
  const StudySummaryScreen({super.key});

  @override
  State<StudySummaryScreen> createState() => _StudySummaryScreenState();
}

class _StudySummaryScreenState extends State<StudySummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ringkasan Pembelajaran"),
        leading: const BackButton(),
      ),
    );
  }
}
