import 'package:flutter/material.dart';

class PostImageItem extends StatelessWidget {
  final Map<String, dynamic> post;
  const PostImageItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post['masjid'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 4),
        Text(post['quote'], style: TextStyle(color: colorScheme.onBackground)),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 5 / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(post['image']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          post['date'],
          style: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: colorScheme.primary,
          ),
        ),
        if (post['dukungan'] != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colorScheme.primary),
                ),
                child: Text(
                  "💚 Dukung Kajian",
                  style: TextStyle(fontSize: 12, color: colorScheme.primary),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${post['dukungan']} orang mendukung",
                style: TextStyle(fontSize: 12, color: colorScheme.onBackground),
              ),
            ],
          ),
        ],
        const SizedBox(height: 16),
        Divider(color: Theme.of(context).dividerColor),
        const SizedBox(height: 12),
      ],
    );
  }
}
