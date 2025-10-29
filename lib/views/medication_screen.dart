import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/widgets/custom_app_bar.dart';
import 'package:medilink/widgets/medicine_card.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Medications',
        subtitle: 'Manage your medications',
        icon: Icons.notifications_outlined,
        onPressed: () {},
        shape: BoxShape.circle,
      ),
      backgroundColor: Color(AppColor.textSecondary),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.sunny, color: Color(AppColor.primary), size: 32),
                  const SizedBox(width: 5),
                  Text(
                    'Morning',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(AppColor.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MedicineCard(
                name: "Metformin",
                dosage: "500mg",
                freq: "Once Daily",
                time: "9:00 AM",
                onDone: () {},
                onEdit: () {},
                onDelete: () {},
              ),
              SizedBox(height: 10),
              Divider(
                color: Color(AppColor.textHint).withOpacity(0.8),
                thickness: 0.5,
                indent: 40,
                endIndent: 40,
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  Icon(
                    Icons.nightlight,
                    color: Color(AppColor.primary),
                    size: 32,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Night',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(AppColor.primary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              MedicineCard(
                name: "Metformin",
                dosage: "500mg",
                freq: "Once Daily",
                time: "9:00 AM",
                onDone: () {},
                onEdit: () {},
                onDelete: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Color(AppColor.medicationColor),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 32,
          color: Color(AppColor.textSecondary),
        ),
      ),
    );
  }
}
