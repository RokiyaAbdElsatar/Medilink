import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onMarkAsTaken;

  const ActionButtons({super.key, this.onDelete, this.onMarkAsTaken});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: onDelete,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Color(AppColor.textSecondary).withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Color(AppColor.red)),
              ),
            ),
            child: Text(
              'Delete Medicine',
              style: TextStyle(
                fontSize: 16,
                color: Color(AppColor.red),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: onMarkAsTaken,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(AppColor.primary),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Mark As Taken',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
