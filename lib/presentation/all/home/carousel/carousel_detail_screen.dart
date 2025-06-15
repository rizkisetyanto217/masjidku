import 'package:flutter/material.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masjidku/presentation/all/home/main/model/caraousel_model.dart';

class CarouselDetailScreen extends StatelessWidget {
  final CarouselModel carousel;

  const CarouselDetailScreen({super.key, required this.carousel});

  Future<void> _launchUrl(BuildContext context) async {
    final uri = Uri.tryParse(carousel.carouselTargetUrl);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal membuka URL')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasUrl = carousel.carouselTargetUrl.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(carousel.carouselTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                carousel.carouselImageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              carousel.carouselCaption,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Type: ${carousel.carouselType}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Target URL: ${carousel.carouselTargetUrl}',
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 8),
            Text('Urutan: ${carousel.carouselOrder}'),
            const SizedBox(height: 8),
            Text(
              'Status: ${carousel.carouselIsActive ? "Aktif" : "Nonaktif"}',
              style: TextStyle(
                color: carousel.carouselIsActive ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            if (hasUrl)
              MainButton(
                label: 'Buka Tautan',
                onPressed: () => _launchUrl(context),
              ),
          ],
        ),
      ),
    );
  }
}
