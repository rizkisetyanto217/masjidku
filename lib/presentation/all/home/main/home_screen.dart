import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/home/carousel.dart';
import 'package:masjidku/component/main/home/header.dart';
import 'package:masjidku/component/main/home/player_info_card.dart';
import 'package:masjidku/component/main/home/quict_access_menu.dart';
import 'package:masjidku/component/main/home/about_section.dart';
import 'package:flutter/services.dart';
import 'package:masjidku/core/constants/quick_access_items.dart';
import 'package:masjidku/presentation/all/home/main/widget/qoute_header_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasjidkuMain extends StatefulWidget {
  const MasjidkuMain({super.key});

  @override
  State<MasjidkuMain> createState() => _MasjidkuMainState();
}

class _MasjidkuMainState extends State<MasjidkuMain> {
  bool isLoggedIn = false;
  String waktuSholat = "Dzuhur 12.00";
  String tanggalHijriyah = "Kamis, 12 Syawwal 1446 H";
  String lokasi = "DKI Jakarta";
  String tentangTitle = "Tentang Aplikasi";
  String tentangDeskripsi =
      "Masjidku adalah aplikasi yang bertujuan untuk membantu management masjid dan lembaga agar menghasilkan kualitas muslimin yang baik.";
  String tentangImage = "assets/images/masjidku-banner.png";

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    getDataFromAPI();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // asumsi key-nya "token"
    if (token != null && token.isNotEmpty) {
      // Kamu bisa tambahkan pengecekan expired atau validasinya juga kalau perlu
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  Future<void> getDataFromAPI() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      waktuSholat = "Ashar 15.00";
      tanggalHijriyah = "Jumat, 13 Syawwal 1446 H";
      lokasi = "Bandung";
    });
  }

  Widget _buildDashboardContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(quote: const QuoteHeaderWidget()),

            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: QuickAccessMenu(items: quickAccessItems),
                      ),
                      const SizedBox(height: 16),
                      PosterCarousel(
                        imagePaths: [
                          "assets/images/masjidku-banner.png",
                          "assets/images/masjidku-banner.png",
                          "assets/images/masjidku-banner.png",
                        ],
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: AboutSection(
                          title: tentangTitle,
                          description: tentangDeskripsi,
                          imagePath: tentangImage,
                          onTapVisi: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => const AlertDialog(
                                    title: Text("Visi Kami"),
                                    content: Text(
                                      "Menjadi platform manajemen masjid...",
                                    ),
                                  ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      context.go('/time-pray');
                    },
                    child: PrayerInfoCard(
                      waktu: waktuSholat,
                      tanggal: tanggalHijriyah,
                      lokasi: lokasi,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor:
              Colors.transparent, // transparan agar warna header kelihatan
          statusBarIconBrightness: Brightness.light, // biar icon putih
        ),
        child: _buildDashboardContent(),
      ),
    );
  }
}
