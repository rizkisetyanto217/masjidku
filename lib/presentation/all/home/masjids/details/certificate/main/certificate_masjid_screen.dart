import 'package:flutter/material.dart';

class CertificateMasjidScreen extends StatefulWidget {
  const CertificateMasjidScreen({super.key});

  @override
  State<CertificateMasjidScreen> createState() =>
      _CertificateMasjidScreenState();
}

class _CertificateMasjidScreenState extends State<CertificateMasjidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sertifikat"),
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
