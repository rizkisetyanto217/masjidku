import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/masjid_profile_dkm_pengajar_cubit.dart';
import '../cubit/masjid_profile_dkm_pengajar_state.dart';
import 'package:masjidku/presentation/all/home/masjids/model/masjid_detail_profile.dart';

class SectionPengurusPengajar extends StatelessWidget {
  final String slug;
  final MasjidDetailModel masjid;

  const SectionPengurusPengajar({
    super.key,
    required this.slug,
    required this.masjid,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.primary;

    return BlocBuilder<MasjidProfileTeacherCubit, MasjidProfileTeacherState>(
      builder: (context, state) {
        if (state is MasjidProfileTeacherLoading) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is MasjidProfileTeacherError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is MasjidProfileTeacherLoaded) {
          final dkm =
              state.speeches
                  .where((e) => e.role.toLowerCase().contains('dkm'))
                  .toList();

          final teachers =
              state.speeches
                  .where(
                    (e) =>
                        e.role.toLowerCase().contains('pengajar') ||
                        e.role.toLowerCase().contains('imam'),
                  )
                  .toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.groups, color: iconColor),
                    const SizedBox(width: 8),
                    Text(
                      "Pengurus & Pengajar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Pengurus dan Pengajar berasal dari masyarakat setempat yang memiliki tujuan ingin memajukan Masjid",
                ),
                const SizedBox(height: 12),
                _InfoTile(
                  icon: Icons.description_outlined,
                  label: "Pengajar dan Imam",
                  subLabel: "Profil Asatizah",
                  badgeCount: teachers.length,
                  onTap:
                      () => context.push(
                        '/masjid/$slug/profile/teacher',
                        extra: masjid,
                      ),
                ),
                const SizedBox(height: 16),
                _InfoTile(
                  icon: Icons.description_outlined,
                  label: "Pengurus",
                  subLabel: "Profil Pengurus DKM",
                  badgeCount: dkm.length,
                  onTap:
                      () => context.push(
                        '/masjid/$slug/profile/dkm',
                        extra: masjid,
                      ),
                ),
              ],
            ),
          );
        }

        return const SizedBox(); // fallback
      },
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subLabel;
  final int badgeCount;
  final VoidCallback? onTap;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.subLabel,
    required this.badgeCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 6),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: theme.colorScheme.primary,
                        child: Text(
                          '$badgeCount',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subLabel,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}