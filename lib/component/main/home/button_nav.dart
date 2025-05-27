import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  final List<IconData> icons = const [
    Icons.home,
    Icons.calendar_month,
    Icons.explore, // tengah
    Icons.settings,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final bool isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? colorScheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border:
                    isSelected
                        ? Border.all(color: colorScheme.primary, width: 2)
                        : null,
              ),
              child: Icon(
                icons[index],
                size: 24,
                color:
                    isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onBackground.withOpacity(0.6),
              ),
            ),
          );
        }),
      ),
    );
  }
}
