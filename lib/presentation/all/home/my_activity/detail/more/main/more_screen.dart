import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseBoxShadow = BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        if (!isDark)
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lainnya"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/my-activity');
          },
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          // Umum
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle("Umum"),
                Container(
                  decoration: baseBoxShadow,
                  child: Column(
                    children: [
                      _MenuTile(
                        icon: Icons.person,
                        label: "Profil",
                        onTap: () => context.go('/my-activity/more/profile'),
                      ),
                      _MenuTile(
                        icon: Icons.font_download,
                        label: "Tampilan",
                        onTap: () => context.go('/my-activity/more/appearance'),
                      ),
                      _MenuTile(
                        icon: Icons.color_lens_outlined,
                        label: "Tema",
                        onTap: () => context.go('/my-activity/more/theme'),
                      ),
                      _MenuTile(
                        icon: Icons.badge_outlined,
                        label: "Sertifikat",
                        onTap:
                            () => context.go('/my-activity/more/certificate'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Dukungan
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _SectionTitle("Dukungan"),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: baseBoxShadow,
            child: Column(
              children: [
                _MenuTile(
                  icon: Icons.favorite_outline,
                  label: "Dukung kami",
                  onTap: () {},
                ),
                _MenuTile(
                  icon: Icons.handshake_outlined,
                  label: "Kerjasama",
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Lainnya
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _SectionTitle("Lainnya"),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: baseBoxShadow,
            child: Column(
              children: [
                _MenuTile(icon: Icons.language, label: "Website", onTap: () {}),
                _MenuTile(
                  icon: Icons.question_answer_outlined,
                  label: "Tanya Jawab",
                  onTap: () => context.go('/my-activity/more/faq'),
                ),
                _MenuTile(
                  icon: Icons.feedback_outlined,
                  label: "Saran dan Masukan",
                  onTap:
                      () => context.go('/my-activity/more/suggestion-feedback'),
                ),
                _MenuTile(
                  icon: Icons.rule,
                  label: "Ketentuan",
                  onTap: () => context.go('/my-activity/more/term'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Keluar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: baseBoxShadow,
            child: _MenuTile(
              icon: Icons.logout,
              label: "Keluar",
              onTap: () {
                // Log out action
              },
              isDestructive: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDestructive ? Colors.red : (isDark ? Colors.white : Colors.black87);

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color)),
      trailing: Icon(
        Icons.chevron_right,
        color: isDark ? Colors.white54 : Colors.black38,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
