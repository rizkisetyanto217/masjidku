import 'package:flutter/material.dart';

class DkmStudyVideoScreen extends StatefulWidget {
  const DkmStudyVideoScreen({super.key});

  @override
  State<DkmStudyVideoScreen> createState() => _DkmStudyVideoScreenState();
}

class _DkmStudyVideoScreenState extends State<DkmStudyVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video"), leading: const BackButton()),
    );
  }
}
