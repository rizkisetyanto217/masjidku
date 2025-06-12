import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickAccessMenu extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const QuickAccessMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            items.map((item) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: QuickAccessMenuItem(
                    icon: item['icon'],
                    label: item['label'],
                    route: item['route'],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class QuickAccessMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const QuickAccessMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.push(route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: colorScheme.primary, size: 28),
          ),
          const SizedBox(height: 6),

          // ✅ Atur tinggi tetap agar semua label rata sejajar
          SizedBox(
            height: 32, // atur sesuai kebutuhan agar cukup untuk 2 baris
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
