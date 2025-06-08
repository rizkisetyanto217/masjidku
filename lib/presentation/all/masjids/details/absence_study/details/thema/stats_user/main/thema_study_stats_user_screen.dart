import 'package:flutter/material.dart';

class DetailThemaStudyStatsUserScreen extends StatefulWidget {
  const DetailThemaStudyStatsUserScreen({super.key});

  @override
  State<DetailThemaStudyStatsUserScreen> createState() =>
      _DetailThemaStudyStatsUserScreenState();
}

class _DetailThemaStudyStatsUserScreenState extends State<DetailThemaStudyStatsUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistik Peserta"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
