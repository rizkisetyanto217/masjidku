import 'package:flutter/material.dart';

class DkmStudyStatsScreen extends StatefulWidget {
  const DkmStudyStatsScreen({super.key});

  @override
  State<DkmStudyStatsScreen> createState() => _DkmStudyStatsScreenState();
}

class _DkmStudyStatsScreenState extends State<DkmStudyStatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistik"),
        leading: const BackButton(),
      ),
    );
  }
}
