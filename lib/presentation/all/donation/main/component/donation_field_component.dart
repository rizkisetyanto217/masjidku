import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonationField extends StatelessWidget {
  final String title;
  final String description;
  final TextEditingController controller;
  final int selected;
  final ValueChanged<int> onChanged;
  final NumberFormat formatter;

  const DonationField({
    super.key,
    required this.title,
    required this.description,
    required this.controller,
    required this.selected,
    required this.onChanged,
    required this.formatter,
  });

  void _showManualInputDialog(BuildContext context) async {
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
      onChanged(result);
      controller.text = formatter.format(10000 * result);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                border: Border.all(color: const Color(0xFF006B64), width: 1.5),
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
                      _showManualInputDialog(context);
                    } else if (val != null) {
                      onChanged(val);
                      controller.text = formatter.format(10000 * val);
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
}
