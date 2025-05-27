import 'package:flutter/material.dart';

class PostTextItem extends StatelessWidget {
  final Map<String, dynamic> post;
  const PostTextItem({super.key, required this.post});

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
        const SizedBox(height: 8),
        Text(
          post['date'],
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.primary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Divider(color: Theme.of(context).dividerColor),
        const SizedBox(height: 12),
      ],
    );
  }
}
