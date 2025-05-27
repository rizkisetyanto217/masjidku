import 'package:flutter/material.dart';

class AbsenceStudyMasjidScreen extends StatefulWidget {
  const AbsenceStudyMasjidScreen({super.key});

  @override
  State<AbsenceStudyMasjidScreen> createState() =>
      _AbsenceStudyMasjidScreenState();
}

class _AbsenceStudyMasjidScreenState extends State<AbsenceStudyMasjidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Absensi & Belajar"),
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
