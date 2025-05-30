import 'package:flutter/material.dart';

class DkmStudyInformationScreen extends StatefulWidget {
  const DkmStudyInformationScreen({super.key});

  @override
  State<DkmStudyInformationScreen> createState() =>
      _DkmStudyInformationScreenState();
}

class _DkmStudyInformationScreenState extends State<DkmStudyInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi"),
        leading: const BackButton(),
      ),
    );
  }
}
