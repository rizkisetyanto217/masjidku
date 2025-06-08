import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/presentation/all/home/masjids/model/masjid_detail_profile.dart';

class DonationBottomButton extends StatelessWidget {
  final String slug;
  final MasjidDetailModel masjid;

  const DonationBottomButton({
    super.key,
    required this.slug,
    required this.masjid,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: MainButton(
          label: "Donasi",
          onPressed:
              () => GoRouter.of(context).push(
                '/masjid/$slug/donation',
                extra: masjid, // ✅ benar: dikirim ke route
              ),
        ),
      ),
    );
  }
}
