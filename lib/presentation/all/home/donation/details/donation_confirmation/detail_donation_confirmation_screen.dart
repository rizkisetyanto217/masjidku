import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';

import 'package:masjidku/presentation/all/home/donation/main/model/donation_arguments.dart';

class DetailDonationConfirm extends StatelessWidget {
  const DetailDonationConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    final extra =
        GoRouter.of(context).routerDelegate.currentConfiguration.extra;

    if (extra is! DonationArguments) {
      return const Scaffold(
        body: Center(child: Text("Data donasi tidak tersedia.")),
      );
    }

    final args = extra;
    final total = args.kajianAmount + args.masjidAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Donasi'),
        leading: const BackButton(),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Donasi Detail',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF00796B),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Berikut adalah rincian donasi detail',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            DonasiTable(
              kajian: args.kajianAmount,
              masjid: args.masjidAmount,
              total: total,
            ),
            const SizedBox(height: 12),
            const DonasiNote(),
            const Spacer(),
            DonasiLanjutButton(totalAmount: total),
          ],
        ),
      ),
    );
  }
}

class DonasiTable extends StatelessWidget {
  final int kajian;
  final int masjid;
  final int total;

  const DonasiTable({
    super.key,
    required this.kajian,
    required this.masjid,
    required this.total,
  });

  String rupiah(int value) => NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  ).format(value);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FixedColumnWidth(40),
        1: FlexColumnWidth(),
        2: IntrinsicColumnWidth(),
      },
      children: [
        _buildTableRow(['No.', 'Deskripsi', 'Rincian'], isHeader: true),
        _buildTableRow(['1', 'Nominal Donasi Kajian', rupiah(kajian)]),
        _buildTableRow(['2', 'Dukungan Aplikasi Masjidku', rupiah(masjid)]),
        _buildTotalRow(),
      ],
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children:
          cells.map((cell) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                cell,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
    );
  }

  TableRow _buildTotalRow() {
    return TableRow(
      children: [
        const SizedBox(),
        Container(
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFC7EFE9),
          child: const Text(
            'Total Transfer',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFC7EFE9),
          child: Text(
            rupiah(total),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class DonasiNote extends StatelessWidget {
  const DonasiNote({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '* Biaya transaksi digunakan untuk biaya pertransaksi.',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(height: 4),
        Text(
          '* Dukungan perkembangan aplikasi digunakan untuk perkembangan dakwah.',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class DonasiLanjutButton extends StatelessWidget {
  final int totalAmount;

  const DonasiLanjutButton({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MainButton(
        label: 'Lanjutkan Donasi',
        backgroundColor: const Color(0xFF00796B),
        foregroundColor: Colors.white,
        onPressed: () {
          // TODO: Ganti dengan aksi sebenarnya (contoh: pembayaran, redirect, dll)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Total donasi: Rp. $totalAmount')),
          );
        },
      ),
    );
  }
}
