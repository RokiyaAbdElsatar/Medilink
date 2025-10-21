import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/screens/edit_medication_screen.dart';

class MedicationDetailsScreen extends StatelessWidget {
  const MedicationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        const Column(
                          children: [
                            Text(
                              'Medications',
                              style: TextStyle(
                                color: AppColor.medicationColor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 50),
                        FloatingActionButton(
                          heroTag: "edit_button",
                          elevation: 0,
                          backgroundColor: AppColor.textSecondary,
                          foregroundColor: AppColor.textSecondary,
                          shape: const CircleBorder(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const EditMedicationScreen(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.edit_document,
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
                    _buildMedicineHeader(),

                    const SizedBox(height: 32),

                    // Details Section
                    _buildDetailsSection(),

                    const SizedBox(height: 32),

                    // Schedule Section
                    _buildScheduleSection(),

                    const SizedBox(height: 40), // بدل Spacer
                    // Action Buttons
                    _buildActionButtons(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineHeader() {
    return Center(
      child: Container(
        height: 240,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.textSecondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColor.primary.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 86,

              decoration: BoxDecoration(
                color: AppColor.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.medication_outlined,
                color: AppColor.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Text(
                  'Aspirin',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColor.medicationColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '100 Mg',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.textHint,
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

  Widget _buildDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.textSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.primary.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.medicationColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailItem('Frequency', 'Once Daily'),
          _buildDetailItem('Time', 'Morning'),
          _buildDetailItem('Start Date', '9 / 8 / 2025'),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.primary.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Schedule',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.medicationColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDayChip('Sat', isSelected: true),
              _buildDayChip('Sun', isSelected: true),
              _buildDayChip('Mon', isSelected: true),
              _buildDayChip('Tue', isSelected: true),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDayChip('Fri', isSelected: true),
              Container(width: 60),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayChip(String day, {bool isSelected = false}) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.days : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColor.primary : Colors.grey[400]!,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                color: isSelected
                    ? AppColor.medicationColor
                    : Colors.grey[600]!,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Delete Button
        Expanded(
          child: TextButton(
            onPressed: () {
              // Delete action
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColor.red.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColor.red.withOpacity(0.3)),
              ),
            ),
            child: Text(
              'Delete Medicine',
              style: TextStyle(
                fontSize: 16,
                color: AppColor.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),
        // Mark as Taken Button
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Mark as taken action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
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
