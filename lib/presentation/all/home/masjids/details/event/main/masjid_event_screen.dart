import 'package:flutter/material.dart';

class MasjidEventScreen extends StatefulWidget {
  const MasjidEventScreen({super.key});

  @override
  State<MasjidEventScreen> createState() => _MasjidEventScreenState();
}

class _MasjidEventScreenState extends State<MasjidEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Masjid Acara"),
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
