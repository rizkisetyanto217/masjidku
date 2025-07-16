import 'package:flutter/material.dart';

class DkmFinancialReportScreen extends StatefulWidget {
  const DkmFinancialReportScreen({super.key});

  @override
  State<DkmFinancialReportScreen> createState() =>
      _DkmFinancialReportScreenState();
}

class _DkmFinancialReportScreenState extends State<DkmFinancialReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Keuangan"),
        leading: const BackButton(),
      ),
    );
  }
}
