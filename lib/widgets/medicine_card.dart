import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/views/medication_details_screen.dart';

class MedicineCard extends StatelessWidget {
  final String name;
  final String dosage;
  final String freq;
  final String time;
  final VoidCallback? onDone;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const MedicineCard({
    super.key,
    required this.name,
    required this.dosage,
    required this.freq,
    required this.time,
    this.onDone,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(AppColor.textSecondary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Color(AppColor.primary)),
      ),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 55,
          height: 60,
          decoration: BoxDecoration(
            color: Color(AppColor.primary).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.medication_outlined,
            color: Color(AppColor.primary),
            size: 30,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Color(AppColor.medicationColor),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dosage,
              style: const TextStyle(
                fontSize: 14,
                color: Color(AppColor.textHint),
              ),
            ),
            const SizedBox(width: 18),

            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Color(AppColor.textHint),
                  size: 12,
                ),
                Text(
                  '$freq      · $time',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(AppColor.textHint),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onDone,
              icon: const Icon(
                Icons.check_circle_outline_rounded,
                color: Color(AppColor.doneChoose),
                size: 24,
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(
                Icons.edit_document,
                color: Color(AppColor.primary),
                size: 24,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: Color(AppColor.red),
                size: 24,
              ),
            ),
          ],
        ),
        onTap:
            onTap ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MedicationDetailsScreen(),
                ),
              );
            },
      ),
    );
  }
}
