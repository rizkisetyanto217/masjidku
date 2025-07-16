import 'package:flutter/material.dart';

class DkmStatsScreen extends StatefulWidget {
  const DkmStatsScreen({super.key});

  @override
  State<DkmStatsScreen> createState() => _DkmStatsScreenState();
}

class _DkmStatsScreenState extends State<DkmStatsScreen> {
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