import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class MedicineHeader extends StatefulWidget {
  final String initialName;
  final String initialDosage;

  const MedicineHeader({
    super.key,
    required this.initialName,
    required this.initialDosage,
  });

  @override
  State<MedicineHeader> createState() => _MedicineHeaderState();
}

class _MedicineHeaderState extends State<MedicineHeader> {
  late String name;
  late String dosage;

  @override
  void initState() {
    super.initState();
    name = widget.initialName;
    dosage = widget.initialDosage;
  }

  void updateMedicine({String? newName, String? newDosage}) {
    setState(() {
      if (newName != null) name = newName;
      if (newDosage != null) dosage = newDosage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 240,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(AppColor.textSecondary),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(AppColor.primary).withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Center(
                child: Container(
                  width: 80,
                  height: 86,
                  decoration: BoxDecoration(
                    color: Color(AppColor.primary).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.medication_outlined,
                    color: Color(AppColor.primary),
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(AppColor.medicationColor),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dosage,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(AppColor.textHint),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
