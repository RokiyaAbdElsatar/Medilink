import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/services/medication_services.dart';
import 'package:medilink/views/navigation_screen.dart';
import 'package:medilink/widgets/custom_app_bar.dart';
import 'package:medilink/widgets/custom_dropdown_with_label.dart';
import 'package:medilink/widgets/labled_text_field.dart';
import 'package:medilink/widgets/schedule_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medilink/models/medication_model.dart';

class AddEditMedicationScreen extends StatefulWidget {
  final Medication? existingMedication;
  const AddEditMedicationScreen({super.key, this.existingMedication});

  @override
  State<AddEditMedicationScreen> createState() =>
      _AddEditMedicationScreenState();
}

class _AddEditMedicationScreenState extends State<AddEditMedicationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  String _frequency = 'Once Day';
  String _timeCategory = 'Morning';
  List<String> _selectedDays = [];
  String _time = '9:00 AM';

  final _medService = MedicationService();

  @override
  void initState() {
    super.initState();
    final med = widget.existingMedication;
    if (med != null) {
      _nameController.text = med.name;
      _dosageController.text = med.dosage;
      _frequency = med.frequency;
      _timeCategory = med.timeCategory;
      _selectedDays = List.from(med.days);
      _time = med.time;
    }
  }

  Future<void> _saveMedication() async {
    if (_nameController.text.isEmpty || _dosageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    try {
      final isEditing = widget.existingMedication != null;
      final id = widget.existingMedication?.id ?? '';

      final med = Medication(
        id: id,
        name: _nameController.text.trim(),
        dosage: _dosageController.text.trim(),
        frequency: _frequency,
        timeCategory: _timeCategory,
        time: _time,
        days: _selectedDays,
        createdAt: widget.existingMedication?.createdAt ?? Timestamp.now(),
      );

      if (isEditing) {
        await _medService.updateMedication(med);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Medication updated successfully!')),
        );
      } else {
        await _medService.addMedication(med);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Medication added successfully!')),
        );
      }

      // ✅ Return updated medication to previous screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NavigationScreen(index: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving medication: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingMedication != null;

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: isEditing ? 'Edit Medication' : 'Add Medication',
            icon: Icons.save_rounded,
            onPressed: _saveMedication,
            shape: BoxShape.rectangle,
          ),
          backgroundColor: const Color(AppColor.textSecondary),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Center(
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: const Color(AppColor.primary).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Icons.medication_liquid_outlined,
                        color: const Color(AppColor.primary),
                        size: 50.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: const Border(
                        top: BorderSide(
                          color: Color(AppColor.primary),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      'Basic Information',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(AppColor.medicationColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      children: [
                        LabeledTextField(
                          controller: _nameController,
                          labelText: 'Medicine Name',
                          hint: 'Ex: Aspirin',
                          icon: Icons.medication_liquid_outlined,
                        ),
                        SizedBox(height: 10.h),
                        LabeledTextField(
                          controller: _dosageController,
                          labelText: 'Dosage',
                          hint: '100 Mg',
                          icon: Icons.hourglass_empty,
                        ),
                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Schedule Settings',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color:  Color(AppColor.medicationColor),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomDropdownWithLabel(
                          labelText: 'Frequency',
                          icon: Icons.access_time,
                          items: const [
                            'Once Day',
                            'Twice Day',
                            'Three Times Day',
                          ],
                          initialValue: _frequency,
                          onChanged: (val) {
                            setState(() => _frequency = val);
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomDropdownWithLabel(
                          labelText: 'Time Category',
                          icon: Icons.access_time,
                          items: const ['Morning', 'Night'],
                          initialValue: _timeCategory,
                          onChanged: (val) {
                            setState(() => _timeCategory = val);
                          },
                        ),
                        SizedBox(height: 10.h),
                        ScheduleSection(
                          selectedDays: _selectedDays,
                          onDaysChanged: (days) {
                            setState(() => _selectedDays = days);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
