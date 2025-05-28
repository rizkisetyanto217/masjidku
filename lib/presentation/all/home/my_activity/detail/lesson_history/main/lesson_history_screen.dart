import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LessonHistoryScreen extends StatefulWidget {
  const LessonHistoryScreen({super.key});

  @override
  State<LessonHistoryScreen> createState() => _LessonHistoryScreenState();
}

class _LessonHistoryScreenState extends State<LessonHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pelajaran"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/my-activity');
          },
        ),
      ),
    );
  }
}
