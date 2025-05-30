import 'package:flutter/material.dart';

class DkmStudySummaryScreen extends StatefulWidget {
  const DkmStudySummaryScreen({super.key});

  @override
  State<DkmStudySummaryScreen> createState() => _DkmStudySummaryScreenState();
}

class _DkmStudySummaryScreenState extends State<DkmStudySummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ringkasan"),
        leading: const BackButton(),
      ),
    );
  }
}
