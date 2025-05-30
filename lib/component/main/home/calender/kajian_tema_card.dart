import 'package:flutter/material.dart';

class KajianTemaCard extends StatelessWidget {
  final String judul;
  final int jumlahKajian;
  final String status;
  final Color statusColor;
  final VoidCallback onTap;

  const KajianTemaCard({
    super.key,
    required this.judul,
    required this.jumlahKajian,
    required this.status,
    required this.statusColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      judul,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("$jumlahKajian Kajian"),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: TextStyle(fontSize: 13, color: statusColor),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
