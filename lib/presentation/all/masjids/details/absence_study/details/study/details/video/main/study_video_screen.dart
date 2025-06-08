import 'package:flutter/material.dart';

class StudyVideoScreen extends StatefulWidget {
  const StudyVideoScreen({super.key});

  @override
  State<StudyVideoScreen> createState() => _StudyVideoScreenState();
}

class _StudyVideoScreenState extends State<StudyVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Pembelajaran"),
        leading: const BackButton(),
      ),
    );
  }
}
