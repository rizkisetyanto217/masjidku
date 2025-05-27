import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/button_nav.dart';
import 'package:masjidku/presentation/all/home/donation/main/model/donation_arguments.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final TextEditingController donasiKajianController = TextEditingController();
  final TextEditingController dukungMasjidController = TextEditingController();

  int selectedKajian = 0;
  int selectedMasjid = 0;

  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  void updateDonasiValue(TextEditingController controller, int multiplier) {
    final value = 10000 * multiplier;
    controller.text = formatter.format(value);
  }

  bool get isButtonEnabled => selectedKajian > 0 || selectedMasjid > 0;

  Future<void> _showManualInputDialog(ValueChanged<int> onConfirm) async {
    final manualController = TextEditingController();
    final result = await showDialog<int>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Masukkan jumlah (1–100)"),
            content: TextField(
              controller: manualController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Misal: 12"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final input = int.tryParse(manualController.text);
                  if (input != null && input >= 1 && input <= 100) {
                    Navigator.pop(context, input);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Input harus antara 1–100")),
                    );
                  }
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );

    if (result != null) {
      onConfirm(result);
    }
  }

  Widget _buildDonasiField({
    required String title,
    required String description,
    required int selected,
    required ValueChanged<int> onChanged,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF006B64),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Rp. 0',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 70,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF006B64), width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: selected > 0 && selected <= 100 ? selected : null,
                  icon: const Icon(Icons.expand_more),
                  isExpanded: true,
                  alignment: Alignment.center,
                  hint: const Text("0"),
                  items: [
                    ...List.generate(10, (i) {
                      final val = i + 1;
                      return DropdownMenuItem(
                        value: val,
                        child: Center(child: Text('$val')),
                      );
                    }),
                    const DropdownMenuItem(
                      value: -1,
                      child: Center(child: Text("...")),
                    ),
                    if (selected > 10 && selected <= 100)
                      DropdownMenuItem(
                        value: selected,
                        child: Center(child: Text('$selected')),
                      ),
                  ],
                  onChanged: (val) async {
                    if (val == -1) {
                      await _showManualInputDialog((value) {
                        onChanged(value);
                        updateDonasiValue(controller, value);
                      });
                    } else if (val != null) {
                      onChanged(val);
                      updateDonasiValue(controller, val);
                    }
                  },
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(description, style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    donasiKajianController.dispose();
    dukungMasjidController.dispose();
    super.dispose();
  }

  String _getRouteForIndex(int index) {
    switch (index) {
      case 0:
        return '/';
      case 1:
        return '/time-pray';
      case 2:
        return '/posting';
      case 3:
        return '/donasi';
      case 4:
        return '/my-activity';
      default:
        return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Donasi Saya"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDonasiField(
              title: "Donasi Kajian",
              description:
                  "100% dana donasi akan diperuntukkan untuk operasional kajian Aqidah bab iman Masjid At-Taufiq.",
              selected: selectedKajian,
              controller: donasiKajianController,
              onChanged: (val) {
                setState(() => selectedKajian = val);
              },
            ),
            _buildDonasiField(
              title: "Dukungan untuk Masjidku",
              description:
                  "Support Masjidku untuk operasional aplikasi dan projek jangka panjang kami.",
              selected: selectedMasjid,
              controller: dukungMasjidController,
              onChanged: (val) {
                setState(() => selectedMasjid = val);
              },
            ),
            const Spacer(),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                side: BorderSide.none,
                backgroundColor: const Color(0xFFFFA726),
              ),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lihat riwayat donasi saya",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 12),
            MainButton(
              label: "Lanjut",
              onPressed:
                  isButtonEnabled
                      ? () {
                        final kajian = 10000 * selectedKajian;
                        final masjid = 10000 * selectedMasjid;

                        context.go(
                          '/donasi/donation-confirmation',
                          extra: DonationArguments(
                            // ✅ sesuai model
                            kajianAmount: kajian,
                            masjidAmount: masjid,
                          ),
                        );
                      }
                      : null,
              backgroundColor:
                  isButtonEnabled ? const Color(0xFF006B64) : Colors.grey,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 3, // misal 4 untuk "Postingan" atau "Kajian"
        onTap: (index) {
          if (index == 3) return; // sudah di halaman ini
          context.go(_getRouteForIndex(index)); // jika pakai go_router
        },
      ),
    );
  }
}
