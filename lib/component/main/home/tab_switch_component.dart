import 'package:flutter/material.dart';

class TabSwitch extends StatelessWidget {
  final List<String> tabs;
  final String selectedTab;
  final ValueChanged<String> onChanged;

  const TabSwitch({
    super.key,
    required this.tabs,
    required this.selectedTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: tabs.map((label) => _buildTab(label)).toList()),
    );
  }

  Widget _buildTab(String label) {
    final isActive = selectedTab == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(label),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF006B64) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
