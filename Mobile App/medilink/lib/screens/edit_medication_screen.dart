import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/screens/medication_detail_screen.dart';

class EditMedicationScreen extends StatelessWidget {
  const EditMedicationScreen({super.key});

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
                              'Medication Details',
                              style: TextStyle(
                                color: AppColor.medicationColor,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
                        FloatingActionButton(
                          heroTag: "save_button",
                          elevation: 0,
                          backgroundColor: AppColor.textSecondary,
                          foregroundColor: AppColor.textSecondary,
                          shape: const CircleBorder(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MedicationDetailsScreen(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.save_outlined,
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
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.medication_liquid_outlined,
                          color: AppColor.primary,
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildDetailsSection(),
                    const SizedBox(height: 32),
                    _buildScheduleSection(),
                    const SizedBox(height: 40),
                    _buildSaveButton(),
                  ],
                ),
              ),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.primary.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Information',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.medicationColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithLabel(
            'Medicine Name',
            'Ex: Aspirin',
            Icons.medication_liquid_outlined,
          ),
          _buildTextFieldWithLabel('Dosage', '100Mg ', Icons.hourglass_empty),
          const SizedBox(height: 24),
          Text(
            'Schedule Settings',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.medicationColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildDropdownWithLabel(
            'Frequency',
            'Once Day',
            Icons.timer_outlined,
            ['Once Day', 'Twice Day', 'Three Times Day'],
          ),
          _buildDropdownWithLabel(
            'Time Category',
            'Morning',
            Icons.timer_outlined,
            ['Morning', 'Afternoon', 'Evening', 'Night', 'Warning'],
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithLabel(String label, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: AppColor.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppColor.textHint),
              prefixIcon: Icon(icon, color: AppColor.primary),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColor.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColor.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownWithLabel(
    String label,
    String currentValue,
    IconData icon,
    List<String> items,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: AppColor.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.primary),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColor.primary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: currentValue,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: AppColor.primary,
                      ),
                      isExpanded: true,
                      style: TextStyle(
                        color: AppColor.textHint,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      items: items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle dropdown change
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Days Of Week',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColor.medicationColor,
                ),
              ),
              _buildSelectAllButton(),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDayChip('Sat', isSelected: true),
              _buildDayChip('Sun', isSelected: true),
              _buildDayChip('Mon', isSelected: true),
              _buildDayChip('Tues', isSelected: true),
              SizedBox(width: 75),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildDayChip('Wed', isSelected: false),
              const SizedBox(width: 12),
              _buildDayChip('Thurs', isSelected: false),
              const SizedBox(width: 12),
              _buildDayChip('Fri', isSelected: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectAllButton() {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Select All',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.primary,
        ),
      ),
    );
  }

  Widget _buildDayChip(String day, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 70,
        height: 38,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.background : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.primary, width: 2),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: isSelected ? AppColor.primary : AppColor.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSaveButton() {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.days,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Save Changes',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
