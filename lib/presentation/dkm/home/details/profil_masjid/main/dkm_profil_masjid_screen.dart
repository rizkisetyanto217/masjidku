import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DkmProfilMasjidScreen extends StatefulWidget {
  const DkmProfilMasjidScreen({super.key});

  @override
  State<DkmProfilMasjidScreen> createState() => _DkmProfilMasjidScreenState();
}

class _DkmProfilMasjidScreenState extends State<DkmProfilMasjidScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Masjid"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 12)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ProfileMenuItem(
            title: "Profil Masjid",
            subtitle: "Data mengenai Masjid",
            onTap: () => context.go('/dkm/profil-masjid/profil-masjid-detail'),
          ),
          const SizedBox(height: 12),
          _ProfileMenuItem(
            title: "Profil DKM dan Pengajar",
            subtitle: "Data mengenai pengurus Masjid dan asatizah",
            onTap: () => context.go('/dkm/profil-masjid/profil-dkm-pengajar'),
          ),
          const SizedBox(height: 12),
          _ProfileMenuItem(
            title: "Sambutan",
            subtitle: "Sambutan dari pengurus dan asatizah Masjid",
            onTap: () => context.go('/dkm/profil-masjid/speech-dkm-pengajar'),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
