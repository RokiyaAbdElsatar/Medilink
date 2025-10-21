import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/screens/medication_detail_screen.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textSecondary,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/curve.png',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 60,
                    left: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FloatingActionButton(
                          heroTag: "back_button",
                          elevation: 0,
                          backgroundColor: AppColor.textSecondary,
                          foregroundColor: AppColor.textSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 36,
                            color: AppColor.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            const Text(
                              'Medications',
                              style: TextStyle(
                                color: AppColor.medicationColor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Manage Your Medications',
                              style: TextStyle(
                                color: AppColor.medicationColor,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 50),
                        FloatingActionButton(
                          heroTag: "notification_button",
                          elevation: 0,
                          backgroundColor: AppColor.textSecondary,
                          foregroundColor: AppColor.textSecondary,
                          shape: const CircleBorder(),
                          onPressed: () {},
                          child: const Icon(
                            Icons.notifications_active,
                            size: 36,
                            color: AppColor.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.sunny, size: 32, color: AppColor.primary),
                        const SizedBox(width: 5),
                        _buildSectionTitle('Morning'),
                      ],
                    ),

                    const SizedBox(height: 10),
                    _buildMedicineCard(
                      context,
                      'Metformin',
                      '500mg',
                      'Once Daily',
                      '09:00 AM',
                    ),
                    _buildMedicineCard(
                      context,
                      'Aspirin',
                      '100mg',
                      'Once Daily',
                      '09:00 AM',
                    ),
                    _buildMedicineCard(
                      context,
                      'Vitamin E',
                      '1000 IU',
                      'Once Daily',
                      '09:00 AM',
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Icon(
                          Icons.nightlight_rounded,
                          color: AppColor.primary,
                          size: 30,
                        ),
                        const SizedBox(width: 5),
                        _buildSectionTitle('Night'),
                      ],
                    ),

                    const SizedBox(height: 10),
                    _buildMedicineCard(
                      context,
                      'Metformin',
                      '500mg',
                      'Once Daily',
                      '09:00 PM',
                    ),
                    _buildMedicineCard(
                      context,
                      'Aspirin',
                      '100mg',
                      'Once Daily',
                      '09:00 PM',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColor.primary,
        onPressed: () {},
        child: const Icon(Icons.add, size: 32, color: AppColor.textSecondary),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColor.primary,
      ),
    );
  }

  Widget _buildMedicineCard(
    BuildContext context,
    String name,
    String dosage,
    String freq,
    String time,
  ) {
    return Card(
      color: AppColor.textSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColor.primary),
      ),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 55,
          height: 60,
          decoration: BoxDecoration(
            color: AppColor.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.medication_outlined,
            color: AppColor.primary,
            size: 30,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: AppColor.medicationColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dosage,
              style: const TextStyle(fontSize: 14, color: AppColor.textHint),
            ),
            const SizedBox(width: 18),
            Text(
              '$freq · $time',
              style: const TextStyle(fontSize: 12, color: AppColor.textHint),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check_circle_outline_rounded,
                color: AppColor.doneChoose,
                size: 24,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_document,
                color: AppColor.primary,
                size: 24,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: AppColor.red,
                size: 24,
              ),
            ),
          ],
        ),
        onTap: () {
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
