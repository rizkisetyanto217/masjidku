import 'package:flutter/material.dart';

class PostImageItem extends StatelessWidget {
  final Map<String, dynamic> post;
  const PostImageItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final imageRatioHeight = screenWidth * 5 / 4;
    final imageHeight = imageRatioHeight > 500 ? 500.0 : imageRatioHeight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PostTitle(post['masjid'], colorScheme),
        const SizedBox(height: 4),
        _PostQuote(post['quote'], colorScheme),
        const SizedBox(height: 12),
        _PostImage(imagePath: post['image'], height: imageHeight),
        const SizedBox(height: 8),
        _PostDate(post['date'], colorScheme),
        if (post['dukungan'] != null) ...[
          const SizedBox(height: 6),
          _PostSupport(post['dukungan'], colorScheme),
        ],
        const SizedBox(height: 16),
        Divider(color: Theme.of(context).dividerColor),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _PostTitle extends StatelessWidget {
  final String? masjid;
  final ColorScheme colorScheme;

  const _PostTitle(this.masjid, this.colorScheme);

  @override
  Widget build(BuildContext context) {
    return Text(
      masjid ?? '',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: colorScheme.onBackground,
      ),
    );
  }
}

class _PostQuote extends StatelessWidget {
  final String? quote;
  final ColorScheme colorScheme;

  const _PostQuote(this.quote, this.colorScheme);

  @override
  Widget build(BuildContext context) {
    return Text(quote ?? '', style: TextStyle(color: colorScheme.onBackground));
  }
}

class _PostImage extends StatelessWidget {
  final String imagePath;
  final double height;

  const _PostImage({required this.imagePath, required this.height});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          width: double.infinity,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PostDate extends StatelessWidget {
  final String? date;
  final ColorScheme colorScheme;

  const _PostDate(this.date, this.colorScheme);

  @override
  Widget build(BuildContext context) {
    return Text(
      date ?? '',
      style: TextStyle(fontSize: 14, height: 1.4, color: colorScheme.primary),
    );
  }
}

class _PostSupport extends StatelessWidget {
  final int dukungan;
  final ColorScheme colorScheme;

  const _PostSupport(this.dukungan, this.colorScheme);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          "$dukungan orang mendukung",
          style: TextStyle(fontSize: 12, color: colorScheme.onBackground),
        ),
      ],
    );
  }
}
