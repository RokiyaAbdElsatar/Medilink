import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/models/medication_model.dart';
import 'package:medilink/services/medication_services.dart';
import 'package:medilink/services/notification_helper.dart';
import 'package:medilink/views/navigation_screen.dart';
import 'package:medilink/widgets/custom_app_bar.dart';
import 'package:medilink/widgets/custom_dropdown_with_label.dart';
import 'package:medilink/widgets/labled_text_field.dart';
import 'package:medilink/widgets/schedule_section.dart';

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

  // support multiple times per day (1..3)
  List<TimeOfDay> _times = [TimeOfDay(hour: 9, minute: 0)];

  final _medService = MedicationService();
  final _notif = NotificationHelper();
  final _timeFormat = DateFormat('h:mm a');

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

      // parse med.time which may be "9:00 AM" or "8:00 AM,2:00 PM"
      final timesRaw = med.time
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      if (timesRaw.isNotEmpty) {
        _times = timesRaw.map((tstr) {
          try {
            final d = _timeFormat.parse(tstr);
            return TimeOfDay(hour: d.hour, minute: d.minute);
          } catch (_) {
            // fallback parse "H:mm" (24h)
            final parts = tstr.split(':');
            if (parts.length >= 2) {
              final h = int.tryParse(parts[0]) ?? 9;
              final m = int.tryParse(parts[1]) ?? 0;
              return TimeOfDay(hour: h, minute: m);
            }
            return TimeOfDay(hour: 9, minute: 0);
          }
        }).toList();
      }
    }

    // ensure count of _times matches frequency initially
    _syncTimesWithFrequency();
    // Initialize notifications (safe to call repeatedly)
    _notif.init();
  }

  // Ensure _times length matches frequency (1,2,3)
  void _syncTimesWithFrequency() {
    final count = _frequency == 'Once Day'
        ? 1
        : _frequency == 'Twice Day'
        ? 2
        : 3;
    while (_times.length < count) {
      // add sensible defaults (spread through day)
      final added = TimeOfDay(hour: (9 + _times.length * 6) % 24, minute: 0);
      _times.add(added);
    }
    if (_times.length > count) {
      _times = _times.sublist(0, count);
    }
  }

  String _formatTimeOfDay(TimeOfDay t) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
    return _timeFormat.format(dt);
  }

  Future<void> _pickTime(int index) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _times[index],
    );
    if (picked != null) {
      setState(() {
        _times[index] = picked;
      });
    }
  }

  Future<void> _saveMedication() async {
    if (_nameController.text.isEmpty ||
        _dosageController.text.isEmpty ||
        _selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    try {
      final isEditing = widget.existingMedication != null;

      // if adding new med, create an ID so we can schedule immediately
      final id =
          widget.existingMedication?.id ??
          FirebaseFirestore.instance.collection('patients').doc().id;

      // save times as comma-separated strings, e.g. "9:00 AM,2:00 PM"
      final timeStrings = _times.map(_formatTimeOfDay).toList();
      final timeJoined = timeStrings.join(',');

      final med = Medication(
        id: id,
        name: _nameController.text.trim(),
        dosage: _dosageController.text.trim(),
        frequency: _frequency,
        timeCategory: _timeCategory,
        time: timeJoined,
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

      // Schedule notifications:
      // - cancel any existing notifications for this med
      // - for each selected time, schedule weekly reminders (or single next if no days)
      await _notif.cancelMedicationNotifications(med.id);

      if (med.days.isNotEmpty) {
        // schedule for each time & each day via NotificationHelper's weekly scheduler
        for (final timeStr in timeStrings) {
          final medCopy = Medication(
            id: med.id,
            name: med.name,
            dosage: med.dosage,
            frequency: med.frequency,
            timeCategory: med.timeCategory,
            time: timeStr,
            days: med.days,
            createdAt: med.createdAt,
          );
          await _notif.scheduleWeeklyReminders(medCopy);
        }
      } else {
        // no specific days -> schedule next occurrence for each time
        for (final timeStr in timeStrings) {
          final medCopy = Medication(
            id: med.id,
            name: med.name,
            dosage: med.dosage,
            frequency: med.frequency,
            timeCategory: med.timeCategory,
            time: timeStr,
            days: [],
            createdAt: med.createdAt,
          );
          await _notif.scheduleNextReminder(medCopy);
        }
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationScreen(index: 3)),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving medication: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // keep times in sync whenever frequency changes
    // (this ensures UI updates when user selects a different frequency)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncTimesWithFrequency();
    });

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
                              color: const Color(AppColor.medicationColor),
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
                            _syncTimesWithFrequency();
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomDropdownWithLabel(
                          labelText: 'Time Category',
                          icon: Icons.access_time,
                          items: const ['Morning', 'Night'],
                          initialValue: _timeCategory,
                          onChanged: (val) =>
                              setState(() => _timeCategory = val),
                        ),
                        SizedBox(height: 10.h),

                        // Time pickers section (1..3 depending on frequency)
                        Column(
                          children: List.generate(_times.length, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Time ${index + 1}: ${_formatTimeOfDay(_times[index])}',
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () => _pickTime(index),
                                    icon: const Icon(Icons.schedule),
                                    label: Text('Pick'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                        AppColor.primary,
                                      ),
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 10.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),

                        SizedBox(height: 10.h),
                        ScheduleSection(
                          selectedDays: _selectedDays,
                          onDaysChanged: (days) =>
                              setState(() => _selectedDays = days),
                        ),
                        SizedBox(height: 20.h),
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
