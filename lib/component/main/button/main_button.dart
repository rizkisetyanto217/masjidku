import 'package:flutter/material.dart';
import 'package:masjidku/core/constants/app_color.dart';

class MainButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;

  const MainButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: backgroundColor ?? colorScheme.primary,
        foregroundColor: foregroundColor ?? colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.white1, // ✅ pakai white1 dari AppColors
        ),
      ),
    );
  }
}
