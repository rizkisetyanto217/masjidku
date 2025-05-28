import 'package:flutter/material.dart';

class FinancialReportMasjidScreen extends StatefulWidget {
  const FinancialReportMasjidScreen({super.key});

  @override
  State<FinancialReportMasjidScreen> createState() =>
      _FinancialReportMasjidScreenState();
}

class _FinancialReportMasjidScreenState
    extends State<FinancialReportMasjidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Keuangan"),
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