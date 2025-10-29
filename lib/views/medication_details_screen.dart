import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/views/add_edit_medication_screen.dart';
import 'package:medilink/widgets/action_buttons.dart';
import 'package:medilink/widgets/custom_app_bar.dart';
import 'package:medilink/widgets/details_section.dart';
import 'package:medilink/widgets/medicine_header.dart';
import 'package:medilink/widgets/schedule_section.dart';

class MedicationDetailsScreen extends StatefulWidget {
  const MedicationDetailsScreen({super.key});

  @override
  State<MedicationDetailsScreen> createState() =>
      _MedicationDetailsScreenState();
}

class _MedicationDetailsScreenState extends State<MedicationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Medication Details',
        icon: Icons.mode_edit,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditMedicationScreen(),
            ),
          );
        },
        shape: BoxShape.rectangle,
      ),
      backgroundColor: Color(AppColor.textSecondary),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MedicineHeader(initialName: "Aspirin", initialDosage: "100 Mg"),
              SizedBox(height: 20),
              DetailsSection(
                frequency: "Once Daily",
                time: "Morning",
                startDate: "9 / 8 / 2025",
              ),
              SizedBox(height: 20),
              ScheduleSection(selectedDays: ['Sat', 'Sun', 'Mon', 'Tue']),
              SizedBox(height: 20),
              ActionButtons(onDelete: () {}, onMarkAsTaken: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
