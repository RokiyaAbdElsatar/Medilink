import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';

class MedicalInfoContainer extends StatelessWidget {
  const MedicalInfoContainer({
    super.key,
    required this.bloodType,
    required this.chronicCondition,
    required this.currentMedications,
    required this.allergies,
    required this.medHistory,
    required this.onEdit,
  });
  final String bloodType;
  final String chronicCondition;
  final String currentMedications;
  final String allergies;
  final String medHistory;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Medical Information",
                        style: TextStyle(
                          color: Color(0xFF106B96),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(AppColor.background),
                        ),
                        child: IconButton(
                          onPressed: onEdit,
                          icon: Icon(
                            Icons.edit_square,
                            color: Color(AppColor.primary),
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.water_drop_outlined,
                              color: Color(AppColor.primary),
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text("$bloodType"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.medical_services_outlined,
                              color: Color(AppColor.primary),
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text("$chronicCondition"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.medication_liquid_outlined,
                              color: Color(AppColor.primary),
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text("$currentMedications"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.block,
                              color: Color(AppColor.primary),
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text("$allergies"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.eco_outlined,
                              color: Color(AppColor.primary),
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text("$medHistory"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
