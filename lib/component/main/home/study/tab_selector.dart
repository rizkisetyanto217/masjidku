import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final List<Map<String, dynamic>> tabs;

  const TabSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = index == selectedIndex;
        final tab = tabs[index];

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: OutlinedButton.icon(
              onPressed: () => onChanged(index),
              icon: Icon(
                tab['icon'] as IconData,
                size: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
              label: Text(
                tab['label'] as String,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor:
                    isSelected ? const Color(0xFF00796B) : Colors.white,
                side: BorderSide(
                  color: isSelected ? const Color(0xFF00796B) : Colors.grey,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        );
      }),
    );
  }
}
