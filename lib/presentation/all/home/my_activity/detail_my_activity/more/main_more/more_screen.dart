import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Lainnya"), leading: const BackButton()),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle("Umum"),
                _MenuTile(
                  icon: Icons.person,
                  label: "Profil",
                  onTap: () => context.go('/my-activity/more/profile'),
                ),

                _MenuTile(
                  icon: Icons.color_lens_outlined,
                  label: "Tema",
                  onTap: () {},
                ),
                _MenuTile(
                  icon: Icons.badge_outlined,
                  label: "Sertifikat",
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle("Dukungan"),
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle("Lainnya"),
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
                _MenuTile(icon: Icons.rule, label: "Ketentuan", onTap: () {}),
              ],
            ),
          ),

          const SizedBox(height: 16),
          // const Divider(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.black87),
      title: Text(
        label,
        style: TextStyle(color: isDestructive ? Colors.red : Colors.black87),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
