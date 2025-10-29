import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class DayChip extends StatelessWidget {
  final String day;
  final bool isSelected;
  final VoidCallback? onTap;

  const DayChip({
    super.key,
    required this.day,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 38,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(AppColor.background)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(AppColor.primary), width: 2),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: const Color(AppColor.primary),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
