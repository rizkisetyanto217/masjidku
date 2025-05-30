import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DkmMainScreen extends StatelessWidget {
  const DkmMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => context.go('/home'), // kembali ke home route
          child: const Text("Masjidku"),
        ),
        actions: const [
          Icon(Icons.person_outline),
          SizedBox(width: 8),
          Icon(Icons.more_vert),
          SizedBox(width: 12),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: const [
            _DkmHeader(),
            SizedBox(height: 8),
            _AddKajianButton(),
            SizedBox(height: 30),
            _DkmMenuGrid(),
          ],
        ),
      ),
    );
  }
}

class _DkmHeader extends StatelessWidget {
  const _DkmHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: GestureDetector(
        onTap: () => GoRouter.of(context).go('/dkm/profil-admin'),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 32, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bapak Harianto",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Staf DKM Masjid Nurul Hidayah",
                    style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.verified, color: Colors.green),
          ],
        ),
      ),
    );
  }
}

class _AddKajianButton extends StatelessWidget {
  const _AddKajianButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            GoRouter.of(context).go('/dkm/study/add-study');
          },
          icon: const Icon(Icons.add, size: 18),
          label: const Text("Tambah Kajian"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00796B),
            foregroundColor: Colors.white, // <== Tambahkan ini!
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}

class _DkmMenuGrid extends StatelessWidget {
  const _DkmMenuGrid();

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.account_balance,
        'label': 'Profil Masjid',
        'route': '/dkm/profil-masjid',
      },
      {
        'icon': Icons.notifications,
        'label': 'Notifikasi',
        'route': '/dkm/notification',
      },
      {'icon': Icons.menu_book, 'label': 'Kajian', 'route': '/dkm/study'},
      {'icon': Icons.event, 'label': 'Acara', 'route': '/dkm/event'},
      {
        'icon': Icons.account_balance_wallet,
        'label': 'Keuangan',
        'route': '/dkm/financial-report',
      },
      {'icon': Icons.info, 'label': 'Informasi', 'route': '/dkm/information'},
      {'icon': Icons.article, 'label': 'Postingan', 'route': '/dkm/post'},
      {'icon': Icons.bar_chart, 'label': 'Statistik', 'route': '/dkm/stats'},
      {
        'icon': Icons.support_agent,
        'label': 'Hubungi Kami',
        'route': '/dkm/call-us',
      },
      {'icon': Icons.logout, 'label': 'Keluar', 'route': '/logout'}, // opsional
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        physics:
            const NeverScrollableScrollPhysics(), // biar tidak scroll dalam scroll
        shrinkWrap: true,
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75, // bisa disesuaikan agar proporsional
        children:
            items.map((item) {
              return _QuickAccessMenuItem(
                icon: item['icon'] as IconData,
                label: item['label'] as String,
                route: item['route'] as String,
              );
            }).toList(),
      ),
    );
  }
}

class _QuickAccessMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const _QuickAccessMenuItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => GoRouter.of(context).go(route),
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
          SizedBox(
            height: 32,
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