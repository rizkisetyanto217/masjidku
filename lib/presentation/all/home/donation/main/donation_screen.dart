// donation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/button/centered_outlined_button.dart';
import 'package:masjidku/component/main/button/small_button_full.dart';
import 'package:masjidku/core/constants/app_spacing.dart';
import 'package:masjidku/presentation/all/home/donation/main/component/donation_field_component.dart';
import 'package:masjidku/presentation/all/home/donation/main/model/donation_arguments.dart';
import 'package:masjidku/presentation/all/home/home/main/cubit/navigation_cubit.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
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
                  "100% dana donasi akan diperuntukkan untuk operasional kajian Aqidah bab iman Masjid At-Taufiq.",
              controller: donasiKajianController,
              selected: selectedKajian,
              onChanged: (val) {
                setState(() => selectedKajian = val);
              },
              formatter: formatter,
            ),
            SmallButtonFull(
              label: 'Masjid At Taqwa, Ciracas, Jakarta Timur',
              onPressed: () {
                // Aksi ketika ditekan
              },
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
              onPressed: () => context.go('/donation/donation-history'),
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
                          '/donation/donation-confirmation',
                          extra: DonationArguments(
                            kajianAmount: kajian,
                            masjidAmount: masjid,
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
