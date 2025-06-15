import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/masjid_model.dart';

class MasjidListTile extends StatelessWidget {
  final MasjidModel masjid;
  final bool isAssetImage;

  const MasjidListTile({
    super.key,
    required this.masjid,
    this.isAssetImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget =
        isAssetImage
            ? Image.asset(
              masjid.masjidImage,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
            : Image.network(
              masjid.masjidImage,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/image-masjid.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                );
              },
            );

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageWidget,
      ),
      title: Text(
        masjid.masjidName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(masjid.masjidLocation),
      onTap:
          () => context.go(
            '/masjid/${masjid.masjidSlug}',
            extra: masjid, // kirim model lengkap
          ),
    );
  }
}
