import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/presentation/all/masjids/details/profile/main/widget/section_pengurus_pengajar.dart';
import 'package:masjidku/presentation/all/masjids/details/profile/main/widget/section_profile_lembaga.dart';
import 'package:masjidku/presentation/all/masjids/details/profile/main/widget/section_sambutan.dart';
import 'package:masjidku/presentation/all/masjids/widget/donation_bottom_button.dart';
import 'package:masjidku/presentation/all/masjids/widget/masjid_header.dart';
import 'package:masjidku/presentation/all/masjids/model/masjid_detail_profile.dart';

class ProfilMasjidScreen extends StatelessWidget {
  final MasjidDetailModel masjid;
  const ProfilMasjidScreen({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          MasjidHeader(
            name: masjid.name,
            bioShort: masjid.bioShort,
            address: masjid.address,
            joinedAt: masjid.joinedAt,
            instagramUrl: masjid.instagramUrl,
            whatsappUrl: masjid.whatsappUrl,
            youtubeUrl: masjid.youtubeUrl,
            masjidSlug: masjid.slug,
            isFollowing: false, // atau ambil dari state jika perlu
            onFollowToggle: () {}, // bisa diabaikan jika non-interaktif di sini
          ),
          GapBorderSeparator(),
          SizedBox(height: 16),
          SectionProfilLembaga(
            masjidId: masjid.masjidId, // ✅ tambahkan ini
          ),

          GapBorderSeparator(),
          SizedBox(height: 16),
          SectionPengurusPengajar(slug: masjid.slug, masjid: masjid),
          GapBorderSeparator(),
          SizedBox(height: 16),
          SectionSambutan(slug: masjid.slug, masjid: masjid), // ✅ benar,
          SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: DonationBottomButton(
        slug: masjid.slug,
        masjid: masjid,
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
