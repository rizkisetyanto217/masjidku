import 'package:flutter/material.dart';

class DkmNotificationScreen extends StatefulWidget {
  const DkmNotificationScreen({super.key});

  @override
  State<DkmNotificationScreen> createState() => _DkmNotificationScreenState();
}

class _DkmNotificationScreenState extends State<DkmNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi"),
        leading: const BackButton(),
      ),
    );
  }
}
