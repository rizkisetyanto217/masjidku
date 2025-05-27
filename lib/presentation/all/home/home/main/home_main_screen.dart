import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/header.dart';
import 'package:masjidku/component/main/player_info_card.dart';
import 'package:masjidku/component/main/quict_access_menu.dart';
import 'package:masjidku/component/main/about_section.dart';
import 'package:masjidku/component/main/button_nav.dart';


class MasjidkuDashboard extends StatefulWidget {
  const MasjidkuDashboard({Key? key}) : super(key: key);

  @override
  State<MasjidkuDashboard> createState() => _MasjidkuDashboardState();
}

class _MasjidkuDashboardState extends State<MasjidkuDashboard> {
  int _currentIndex = 0;

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
    {"icon": Icons.info_outline, "label": "Informasi", "route": "/informasi"},
    {
      "icon": Icons.account_balance,
      "label": "Masjid & Lembaga",
      "route": "/lembaga",
    },
    {"icon": Icons.handshake, "label": "Kerjasama", "route": "/kerjasama"},
    {"icon": Icons.explore, "label": "Jelajahi", "route": "/jelajahi"},
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

  /// Route Mapping
  void _handleBottomNavTap(int index) {
    switch (index) {
      case 0:
      case 1:
        context.go('/time-pray');
        break;
      case 2:
        context.go('/posting');
        break;
      case 3:
        context.go('/donasi');
        break;
      case 4:
        context.go('/my-activity');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: _handleBottomNavTap,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Halaman 0: Dashboard
          SafeArea(
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
                              child: QuickAccessMenu(items: quickAccessItems),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
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
          ),

          // Halaman 1: Kalender
          const Center(child: Text("Halaman Kalender")),
        ],
      ),
    );
  }
}
