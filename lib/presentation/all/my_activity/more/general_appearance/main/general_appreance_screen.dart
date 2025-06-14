import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/core/themes/theme_cubit.dart';

class AppreanceScreen extends StatefulWidget {
  const AppreanceScreen({super.key});

  @override
  State<AppreanceScreen> createState() => _AppreanceScreenState();
}

class _AppreanceScreenState extends State<AppreanceScreen> {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tampilan Umum"),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            leading: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text("Mode Gelap"),
            subtitle: Text(isDark ? "Aktif" : "Nonaktif"),
            trailing: Switch(
              value: isDark,
              onChanged: (val) {
                themeCubit.toggleTheme();
              },
            ),
            onTap: () {
              themeCubit.toggleTheme();
            },
          ),
        ),
      ),
    );
  }
}
