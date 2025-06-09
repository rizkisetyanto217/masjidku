import 'package:flutter/material.dart';

class StudyInformationScreen extends StatefulWidget {
  const StudyInformationScreen({super.key});

  @override
  State<StudyInformationScreen> createState() => _StudyInformationScreenState();
}

class _StudyInformationScreenState extends State<StudyInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi Pembelajaran"),
        leading: const BackButton(),
      ),
    );
  }
}
