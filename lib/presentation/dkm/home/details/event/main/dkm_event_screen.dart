import 'package:flutter/material.dart';

class DkmEventScreen extends StatefulWidget {
  const DkmEventScreen({super.key});

  @override
  State<DkmEventScreen> createState() => _DkmEventScreenState();
}

class _DkmEventScreenState extends State<DkmEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Event"), leading: const BackButton()),
    );
  }
}
