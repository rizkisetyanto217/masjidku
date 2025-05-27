import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class ProfilMasjidPage extends StatelessWidget {
  const ProfilMasjidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      bottomNavigationBar: const DonasiBottomButton(),
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
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.chevron_right),
            label: const Text("Profil Lengkap"),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(icon: Icons.groups, title: "Pengurus & Pengajar"),
          const SizedBox(height: 8),
          const Text(
            "Pengurus dan Pengajar berasal dari masyarakat setempat yang memiliki tujuan ingin memajukan Masjid",
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _InfoTile(label: "Pengurus", badgeCount: 6)),
              SizedBox(width: 12),
              Expanded(
                child: _InfoTile(label: "Pengajar dan Imam", badgeCount: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final int badgeCount;

  const _InfoTile({required this.label, required this.badgeCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.description_outlined),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.teal.shade700,
            child: Text(
              badgeCount.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
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
            onPressed: () {},
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

class DonasiBottomButton extends StatelessWidget {
  const DonasiBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: MainButton(label: "Donasi", onPressed: () {}),
      ),
    );
  }
}
