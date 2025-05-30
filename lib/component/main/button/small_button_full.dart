import 'package:flutter/material.dart';

class SmallButtonFull extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final IconData? trailingIcon; // ✅ Tambahan parameter ikon kanan

  const SmallButtonFull({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? const Color(0xFF00A651),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailingIcon != null)
              Icon(trailingIcon, size: 14, color: textColor ?? Colors.white),
          ],
        ),
      ),
    );
  }
}
