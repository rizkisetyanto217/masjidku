import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SmallButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // ✅ ini bikin tombol full width
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00A651), // hijau Figma
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // ✅ atur isi kiri & kanan
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // const Icon(Icons.arrow_forward_ios_rounded, size: 14),
          ],
        ),
      ),
    );
  }
}
