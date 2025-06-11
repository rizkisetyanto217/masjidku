import 'package:flutter/material.dart';

class StudyCardImage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String startTime;
  final String description;
  final VoidCallback? onTap;

  const StudyCardImage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.startTime,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage =
        imageUrl.isNotEmpty && Uri.tryParse(imageUrl)?.hasAbsolutePath == true;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDDDDDD)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  hasImage
                      ? Image.network(
                        imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/image-masjid.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                      : Image.asset(
                        'assets/images/image-masjid.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    startTime,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
