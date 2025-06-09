import 'package:flutter/material.dart';

class DetailThemaStudyFaqScreen extends StatefulWidget {
  const DetailThemaStudyFaqScreen({super.key});

  @override
  State<DetailThemaStudyFaqScreen> createState() => _DetailThemaStudyFaqScreenState();
}

class _DetailThemaStudyFaqScreenState extends State<DetailThemaStudyFaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tanya Jawab"),
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
