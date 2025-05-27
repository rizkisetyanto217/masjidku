import 'package:flutter/material.dart';

class PlanHomeScreen extends StatefulWidget {
  const PlanHomeScreen({super.key});

  @override
  State<PlanHomeScreen> createState() => _PlanHomeScreenState();
}

class _PlanHomeScreenState extends State<PlanHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rencana MasjidKu"),
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
