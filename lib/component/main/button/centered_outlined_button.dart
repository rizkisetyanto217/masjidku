import 'package:flutter/material.dart';

class CenteredOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CenteredOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
            side: BorderSide.none,
            backgroundColor: const Color(0xFFFFA726),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
