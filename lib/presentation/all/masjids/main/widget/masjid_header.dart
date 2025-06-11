import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/core/utils/date_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/src/share_plus_platform_interface.dart'
// show ShareTextParams;

class MasjidHeader extends StatelessWidget {
  final String name;
  final String bioShort;
  final String address;
  final String joinedAt;
  final String instagramUrl;
  final String whatsappUrl;
  final String youtubeUrl;
  final bool isFollowing;
  final String masjidSlug;
  final VoidCallback onFollowToggle;

  const MasjidHeader({
    super.key,
    required this.name,
    required this.bioShort,
    required this.address,
    required this.joinedAt,
    required this.instagramUrl,
    required this.whatsappUrl,
    required this.youtubeUrl,
    required this.isFollowing,
    required this.masjidSlug,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Image Placeholder
        Container(
          height: 150,
          color: Colors.grey[300],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 24,
              color: Colors.black54,
            ),
          ),
        ),

        // Masjid Info
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and Follow Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  isFollowing
                      ? OutlinedButton(
                        onPressed: onFollowToggle,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          side: const BorderSide(color: Color(0xFF006B64)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(0, 32),
                        ),
                        child: const Text(
                          "Mengikuti",
                          style: TextStyle(
                            color: Color(0xFF006B64),
                            fontSize: 14,
                          ),
                        ),
                      )
                      : ElevatedButton(
                        onPressed: onFollowToggle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006B64),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(0, 32),
                        ),
                        child: const Text(
                          "Ikuti",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                ],
              ),

              const SizedBox(height: 4),
              Text(
                bioShort,
                style: const TextStyle(fontSize: 13, color: Color(0xFF9E9E9E)),
              ),

              const SizedBox(height: 4),
              Text(address, style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 4),
              Text(
                "Bergabung pada ${formatJoinedDate(joinedAt)}",
                style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
              ),
              const SizedBox(height: 4),

              // Media Sosial + Tombol Share dalam satu baris
              Row(
                children: [
                  if (whatsappUrl.isNotEmpty)
                    IconButton(
                      onPressed: () => _launchURL(whatsappUrl),
                      icon: const Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                      ),
                    ),
                  if (instagramUrl.isNotEmpty)
                    IconButton(
                      onPressed: () => _launchURL(instagramUrl),
                      icon: const Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.pink,
                      ),
                    ),
                  if (youtubeUrl.isNotEmpty)
                    IconButton(
                      onPressed: () => _launchURL(youtubeUrl),
                      icon: const Icon(
                        FontAwesomeIcons.youtube,
                        color: Colors.red,
                      ),
                    ),
                  TextButton.icon(
                    onPressed: () async {
                      final url =
                          'https://web-six-theta-13.vercel.app/#/masjid/$masjidSlug';
                      final message =
                          'Yuk kunjungi masjid $name!\nAlamat: $address\n\nKunjungi di: $url';

                      await Share.share(message);
                    },
                    icon: const Icon(Icons.share, color: Colors.teal),
                    label: const Text(
                      'Bagikan',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),

              // Dummy Stats
              Row(
                children: const [
                  Text("300 Postingan", style: TextStyle(fontSize: 13)),
                  SizedBox(width: 20),
                  Text("300 Pengikut", style: TextStyle(fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Tidak bisa membuka URL: $url');
    }
  }
}
