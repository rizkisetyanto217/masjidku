import 'package:flutter/material.dart';

class CollaborationHomeScreen extends StatefulWidget {
  const CollaborationHomeScreen({super.key});

  @override
  State<CollaborationHomeScreen> createState() =>
      _CollaborationHomeScreenState();
}

class _CollaborationHomeScreenState extends State<CollaborationHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kerjasama Masjid"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
        // backgroundColor: Colors.white,
      ),
    );
  }
}