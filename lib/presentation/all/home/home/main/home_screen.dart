import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/home/carousel.dart';
import 'package:masjidku/component/main/home/header.dart';
import 'package:masjidku/component/main/home/player_info_card.dart';
import 'package:masjidku/component/main/home/quict_access_menu.dart';
import 'package:masjidku/component/main/home/about_section.dart';
import 'package:flutter/services.dart';
import 'package:masjidku/core/constants/app_color.dart';

class MasjidkuMain extends StatefulWidget {
  const MasjidkuMain({Key? key}) : super(key: key);

  @override
  State<MasjidkuMain> createState() => _MasjidkuMainState();
}

class _MasjidkuMainState extends State<MasjidkuMain> {
  String waktuSholat = "Dzuhur 12.00";
  String tanggalHijriyah = "Kamis, 12 Syawwal 1446 H";
  String lokasi = "DKI Jakarta";
  String kutipanHeader =
      "“Sesungguhnya ilmu adalah rasa takut kepada Allah ta’ala.”";

  String tentangTitle = "Tentang Aplikasi";
  String tentangDeskripsi =
      "Masjidku adalah aplikasi yang bertujuan untuk membantu management masjid dan lembaga agar menghasilkan kualitas muslimin yang baik.";
  String tentangImage = "assets/images/masjidku-banner.png";

  final List<Map<String, dynamic>> quickAccessItems = [
    {
      "icon": Icons.info_outline,
      "label": "Informasi",
      "route": "/home/information", // ✅ Benar
    },
    {
      "icon": Icons.account_balance,
      "label": "Masjid & Lembaga",
      "route": "/search", // Tambahkan rute ini kalau kamu punya rutenya
    },
    {
      "icon": Icons.handshake,
      "label": "Kerjasama",
      "route": "/home/collaboration", // ✅ Sesuai dengan definisi rute
    },
    {
      "icon": Icons.explore,
      "label": "Jelajahi",
      "route": "/home/explore", // ✅ Sesuai dengan definisi rute
    },
  ];

  @override
  void initState() {
    super.initState();
    getDataFromAPI();
  }

  Future<void> getDataFromAPI() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      waktuSholat = "Ashar 15.00";
      tanggalHijriyah = "Jumat, 13 Syawwal 1446 H";
      lokasi = "Bandung";
      kutipanHeader = "“Ilmu yang bermanfaat akan terus mengalir pahalanya.”";
    });
  }

  Widget _buildDashboardContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(quote: kutipanHeader),
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary, // Sesuaikan dengan header kamu
        statusBarIconBrightness: Brightness.light, // Biar ikon putih
      ),
      child: Scaffold(body: _buildDashboardContent()),
    );
  }
}
