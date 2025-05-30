import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/core/themes/theme_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderSection extends StatelessWidget {
  final String quote;

  const HeaderSection({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(),
          const SizedBox(height: 16),
          _QuoteSection(quote: quote),
          const SizedBox(height: 16),
          const _SearchBar(),
          const SizedBox(height: 16),
          const _CollaborationInfo(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset("assets/images/masjidku-logo.png", height: 28),
            const SizedBox(width: 8),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () => GoRouter.of(context).go('/dkm'),
              child: const Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: Colors.white,
              ),
              onPressed: () {
                themeCubit.toggleTheme();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _QuoteSection extends StatelessWidget {
  final String quote;
  const _QuoteSection({required this.quote});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      quote,
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: colorScheme.onPrimary,
        fontSize: 16,
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        context.go('/search');
      },
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Cari Masjid',
            hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.5)),
            prefixIcon: Icon(Icons.search, color: colorScheme.onSurface),
            filled: true,
            fillColor: colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

class _CollaborationInfo extends StatelessWidget {
  const _CollaborationInfo();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      "Alhamdulillah, telah bekerjasama dengan 10+ Masjid dan Lembaga",
      style: TextStyle(color: colorScheme.onPrimary, fontSize: 12),
    );
  }
}
