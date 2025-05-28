import 'package:flutter/material.dart';

class AppreanceScreen extends StatefulWidget {
  const AppreanceScreen({super.key});

  @override
  State<AppreanceScreen> createState() => _AppreanceScreenState();
}

class _AppreanceScreenState extends State<AppreanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tampilan Umum"),
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
