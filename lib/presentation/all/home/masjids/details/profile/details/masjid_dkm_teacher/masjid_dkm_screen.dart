import 'package:flutter/material.dart';

class MasjidDKMScreen extends StatefulWidget {
  const MasjidDKMScreen({super.key});

  @override
  State<MasjidDKMScreen> createState() => _MasjidDKMScreenState();
}

class _MasjidDKMScreenState extends State<MasjidDKMScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil DKM Masjid"),
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
