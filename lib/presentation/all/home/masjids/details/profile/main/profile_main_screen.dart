import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class ProfilMasjidPage extends StatelessWidget {
  const ProfilMasjidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          HeaderMasjid(),
          GapBorderSeparator(),
          SizedBox(height: 16),
          SectionProfilLembaga(),
          GapBorderSeparator(),
          SizedBox(height: 16),
          SectionPengurusPengajar(),
          GapBorderSeparator(),
          SizedBox(height: 16),
          SectionSambutan(),
          SizedBox(height: 100),
        ],
      ),
      bottomNavigationBar: const DonationBottomButton(),
    );
  }
}

class HeaderMasjid extends StatelessWidget {
  const HeaderMasjid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          color: Colors.grey[300],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () => context.go('/masjid'),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 24,
              color: Colors.black54,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/image-masjid.png', // ganti sesuai path ikon masjid
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Masjid Jami’ At-Taqwa',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00796B),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Dikelola oleh DKM Masjid untuk ummat muslim',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 4),
              const Text(
                'Jln. Sawo Besar No.95. Tanah Abang, Jakarta Pusat, DKI Jakarta',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 4),
              const Text(
                'Bergabung pada April 2025',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text('300 ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Postingan'),
                  SizedBox(width: 16),
                  Text('300 ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Pengikut'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SectionProfilLembaga extends StatelessWidget {
  const SectionProfilLembaga({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(icon: Icons.menu_book, title: "Profil Lembaga"),
          const SizedBox(height: 8),
          const Text(
            "Masjid At-Taqwa didirikan pada tahun 2000 dengan tujuan untuk menjadi tempat ibadah untuk warga Ciracas dan sekitarnya",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.go('/masjid/profile/full-profile'),
              icon: const Icon(Icons.chevron_right),
              label: const Text("Profil Lengkap"),
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft, // ⬅️ label tetap di kiri
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionPengurusPengajar extends StatelessWidget {
  const SectionPengurusPengajar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups, color: iconColor),
              const SizedBox(width: 8),
              Text(
                "Pengurus & Pengajar",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Pengurus dan Pengajar berasal dari masyarakat setempat yang memiliki tujuan ingin memajukan Masjid",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          _InfoTile(
            icon: Icons.description_outlined,
            label: "Pengajar dan Imam",
            subLabel: "Profil Asatizah",
            badgeCount: 11,
            onTap: () => GoRouter.of(context).push('/masjid/profile/teacher'),
          ),
          const SizedBox(height: 16),
          _InfoTile(
            icon: Icons.description_outlined,
            label: "Pengurus",
            subLabel: "Profil Pengurus DKM",
            badgeCount: 6,
            onTap: () => GoRouter.of(context).push('/masjid/profile/dkm'),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subLabel;
  final int badgeCount;
  final VoidCallback? onTap;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.subLabel,
    required this.badgeCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 6),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: theme.colorScheme.primary,
                        child: Text(
                          '$badgeCount',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subLabel,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class SectionSambutan extends StatelessWidget {
  const SectionSambutan({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🗣️ Sambutan dan Motivasi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF00796B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tulisan dari pengurus, pengajar dan jamaah Masjid At-Taqwa",
          ),
          const SizedBox(height: 12),
          const _SambutanCard(
            name: "Muhammad",
            role: "Pengajar",
            message:
                "Semoga Allah ta’ala mudahkan kita dalam menuntut ilmu agama. Allah ta’ala berikan kemudahan bagi kita semua terutama bagi orang-orang yang sedang kesulitan agar dilancarkan usahanya..",
          ),
          const SizedBox(height: 8),
          const _SambutanCard(
            name: "Budi",
            role: "Ketua DKM",
            message:
                "Semoga Allah ta’ala mudahkan kita dalam menuntut ilmu agama. Allah ta’ala berikan kemudahan bagi kita semua terutama bagi orang-orang yang sedang kesulitan agar dilancarkan usahanya.",
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed:
                () => GoRouter.of(context).push('/masjid/profile/speech'),
            icon: const Icon(Icons.chevron_right),
            label: const Text("Selengkapnya"),
          ),
        ],
      ),
    );
  }
}

class _SambutanCard extends StatelessWidget {
  final String name;
  final String role;
  final String message;

  const _SambutanCard({
    required this.name,
    required this.role,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(role, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(message, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF00796B),
          ),
        ),
      ],
    );
  }
}

class DonationBottomButton extends StatelessWidget {
  const DonationBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: MainButton(
          label: "Donasi",
          onPressed: () => GoRouter.of(context).push('/masjid/donation'),
        ),
      ),
    );
  }
}
