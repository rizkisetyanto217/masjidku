import 'package:flutter/material.dart';

class MasjidTeacherScreeen extends StatefulWidget {
  const MasjidTeacherScreeen({super.key});

  @override
  State<MasjidTeacherScreeen> createState() => _MasjidTeacherScreeenState();
}

class _MasjidTeacherScreeenState extends State<MasjidTeacherScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengajar Masjid"),
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
