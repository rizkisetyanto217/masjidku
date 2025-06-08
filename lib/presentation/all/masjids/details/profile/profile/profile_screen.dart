import 'package:flutter/material.dart';
import 'package:masjidku/presentation/all/masjids/details/profile/main/model/masjid_profile_model.dart';

class MasjidProfilScreen extends StatelessWidget {
  final MasjidProfileModel profile;

  const MasjidProfilScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Lembaga"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 8)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.story,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Text(
                "Visi:",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(profile.visi, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                "Misi:",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(profile.misi, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                "Tahun Berdiri: ${profile.foundedYear}",
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              if (profile.other.isNotEmpty)
                Text(
                  "Catatan: ${profile.other}",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
