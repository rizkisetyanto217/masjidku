import 'package:flutter/material.dart';

class MasjidDonationScreen extends StatefulWidget {
  const MasjidDonationScreen({super.key});

  @override
  State<MasjidDonationScreen> createState() => _MasjidDonationScreenState();
}

class _MasjidDonationScreenState extends State<MasjidDonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donasi Masjid"),
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
