// ✅ Updated MasjidDonationScreen to accept masjid from route and use cubit
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/button/centered_outlined_button.dart';
import 'package:masjidku/component/main/button/small_button_full.dart';
import 'package:masjidku/core/constants/app_spacing.dart';
import 'package:masjidku/presentation/all/donation/main/component/donation_field_component.dart';

import 'package:masjidku/presentation/all/home/main/cubit/navigation_cubit.dart';
import 'package:masjidku/presentation/all/masjids/main/model/masjid_detail_profile.dart';

class MasjidDonationScreen extends StatefulWidget {
  final MasjidDetailModel masjid;

  const MasjidDonationScreen({super.key, required this.masjid});

  @override
  State<MasjidDonationScreen> createState() => _MasjidDonationScreenState();
}

class _MasjidDonationScreenState extends State<MasjidDonationScreen> {
  final TextEditingController donasiKajianController = TextEditingController();
  final TextEditingController dukungMasjidController = TextEditingController();

  int selectedKajian = 0;
  int selectedMasjid = 0;

  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    context.read<NavigationCubit>().changeTab(3);
  }

  @override
  void dispose() {
    donasiKajianController.dispose();
    dukungMasjidController.dispose();
    super.dispose();
  }

  bool get isButtonEnabled => selectedKajian > 0 || selectedMasjid > 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donasi Saya")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DonationField(
              title: "Donasi Kajian",
              description:
                  "100% dana donasi akan diperuntukkan untuk operasional kajian Aqidah bab iman Masjid ${widget.masjid.name}.",
              controller: donasiKajianController,
              selected: selectedKajian,
              onChanged: (val) {
                setState(() => selectedKajian = val);
              },
              formatter: formatter,
            ),
            SmallButtonFull(
              label: '${widget.masjid.name}, ${widget.masjid.address}',
              onPressed: () {},
            ),
            AppSpacing.lg,
            DonationField(
              title: "Dukungan untuk Masjidku",
              description:
                  "Support Masjidku untuk operasional aplikasi dan projek jangka panjang kami.",
              controller: dukungMasjidController,
              selected: selectedMasjid,
              onChanged: (val) {
                setState(() => selectedMasjid = val);
              },
              formatter: formatter,
            ),
            const Spacer(),
            CenteredOutlinedButton(
              label: "Lihat riwayat donasi saya",
              onPressed: () => context.go('/donasi/donation-history'),
            ),
            const SizedBox(height: 12),
            MainButton(
              label: "Lanjut",
              onPressed:
                  isButtonEnabled
                      ? () {
                        final kajian = 10000 * selectedKajian;
                        final masjid = 10000 * selectedMasjid;

                        context.go(
                          '/donasi/donation-confirmation',
                          extra: DonationArguments(
                            kajianAmount: kajian,
                            masjidAmount: masjid,
                            masjidId: widget.masjid.masjidId,
                            masjidSlug: widget.masjid.slug,
                          ),
                        );
                      }
                      : null,
              backgroundColor:
                  isButtonEnabled ? const Color(0xFF006B64) : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class DonationArguments {
  final int kajianAmount;
  final int masjidAmount;
  final String masjidId;
  final String masjidSlug;

  DonationArguments({
    required this.kajianAmount,
    required this.masjidAmount,
    required this.masjidId,
    required this.masjidSlug,
  });
}
