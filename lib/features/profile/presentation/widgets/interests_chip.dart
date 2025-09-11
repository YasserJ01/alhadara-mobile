import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class InterestsChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const InterestsChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}