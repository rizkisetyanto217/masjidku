import 'package:flutter/material.dart';

class DkmCallUsScreen extends StatefulWidget {
  const DkmCallUsScreen({super.key});

  @override
  State<DkmCallUsScreen> createState() => _DkmCallUsScreenState();
}

class _DkmCallUsScreenState extends State<DkmCallUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Call Us"), leading: const BackButton()),
    );
  }
}
