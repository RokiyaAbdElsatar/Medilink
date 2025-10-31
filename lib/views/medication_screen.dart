import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/models/medication_model.dart';
import 'package:medilink/services/medication_services.dart';
import 'package:medilink/views/add_edit_medication_screen.dart';
import 'package:medilink/views/medication_details_screen.dart';
import 'package:medilink/widgets/custom_app_bar.dart';
import 'package:medilink/widgets/medicine_card.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final _medService = MedicationService();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Medications',
            subtitle: 'Manage your medications',
            icon: Icons.notifications_outlined,
            onPressed: () {},
            shape: BoxShape.circle,
          ),
          backgroundColor: const Color(AppColor.textSecondary),
          body: Padding(
            padding: EdgeInsets.all(18.w),
            child: StreamBuilder<List<Medication>>(
              stream: _medService.getUserMedications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final meds = snapshot.data ?? [];

                if (meds.isEmpty) {
                  return const Center(
                    child: Text(
                      'No medications yet.\nTap + to add one!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                // Separate morning and night meds
                final morningMeds = meds
                    .where((m) => m.timeCategory == 'Morning')
                    .toList();
                final nightMeds = meds
                    .where((m) => m.timeCategory == 'Night')
                    .toList();

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🌅 Morning Section
                      if (morningMeds.isNotEmpty) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.sunny,
                              color: Color(AppColor.primary),
                              size: 32.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              'Morning',
                              style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(AppColor.primary),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        ...morningMeds.map(
                          (med) => MedicineCard(
                            name: med.name,
                            dosage: med.dosage,
                            freq: med.frequency,
                            time: med.time,
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEditMedicationScreen(
                                    existingMedication: med,
                                  ),
                                ),
                              );
                            },
                            onDelete: () async {
                              await _medService.deleteMedication(med.id);
                            },
                            onDone: () {
                              // You can implement marking as taken
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MedicationDetailsScreen(medication: med),
                                ),
                              );
                            },
                          ),
                        ),
                        Divider(
                          color: Color(AppColor.textHint).withOpacity(0.8),
                          thickness: 0.5,
                          indent: 40.w,
                          endIndent: 40.w,
                        ),
                        SizedBox(height: 10.h),
                      ],

                      // 🌙 Night Section
                      if (nightMeds.isNotEmpty) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.nightlight,
                              color: Color(AppColor.primary),
                              size: 32.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              'Night',
                              style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(AppColor.primary),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        ...nightMeds.map(
                          (med) => MedicineCard(
                            name: med.name,
                            dosage: med.dosage,
                            freq: med.frequency,
                            time: med.time,
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEditMedicationScreen(
                                    existingMedication: med,
                                  ),
                                ),
                              );
                            },
                            onDelete: () async {
                              await _medService.deleteMedication(med.id);
                            },
                            onDone: () {},
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MedicationDetailsScreen(medication: med),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Color(AppColor.medicationColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddEditMedicationScreen(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              size: 30.sp,
              color: Color(AppColor.textSecondary),
            ),
          ),
        );
      },
    );
  }
}
