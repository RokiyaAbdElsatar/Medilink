import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/widgets/custom_app_bar.dart';
import 'package:medilink/widgets/custom_dropdown_with_label.dart';
import 'package:medilink/widgets/day_chip.dart';
import 'package:medilink/widgets/labled_text_field.dart';
import 'package:medilink/widgets/schedule_selection.dart';

class AddEditMedicationScreen extends StatefulWidget {
  const AddEditMedicationScreen({super.key});

  @override
  State<AddEditMedicationScreen> createState() =>
      _AddEditMedicationScreenState();
}

class _AddEditMedicationScreenState extends State<AddEditMedicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Medication Details',
        icon: Icons.save_rounded,
        onPressed: () {},
        shape: BoxShape.rectangle,
      ),
      backgroundColor: Color(AppColor.textSecondary),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Color(AppColor.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.medication_liquid_outlined,
                  color: Color(AppColor.primary),
                  size: 50,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: const Border(
                  top: BorderSide(color: Color(AppColor.primary), width: 1),
                ),
              ),
              child: Text(
                'Basic Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(AppColor.medicationColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 18.0),
              child: Column(
                children: [
                  LabeledTextField(
                    labelText: 'Medicine Name',
                    hint: 'Ex: Aspirin',
                    icon: Icons.medication_liquid_outlined,
                  ),
                  SizedBox(height: 10),
                  LabeledTextField(
                    labelText: 'Dosage',
                    hint: '100 Mg',
                    icon: Icons.hourglass_empty,
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Schedule Settings',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(AppColor.medicationColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomDropdownWithLabel(
                    labelText: 'Frequency',
                    icon: Icons.access_time,
                    items: ['Once Day', 'Twice Day', 'Three Times Day'],
                    initialValue: 'Once Day',
                  ),
                  SizedBox(height: 10),
                  CustomDropdownWithLabel(
                    labelText: 'Time Category',
                    icon: Icons.access_time,
                    items: ['Morning', 'Night'],
                    initialValue: 'Morning',
                  ),
                  ScheduleSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
