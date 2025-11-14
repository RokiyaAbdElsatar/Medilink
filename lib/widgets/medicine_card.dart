import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/services/medication_services.dart';
import 'package:medilink/views/add_edit_medication_screen.dart';
import 'package:medilink/views/medication_details_screen.dart';

class MedicineCard extends StatefulWidget {
  final String id;
  final String name;
  final String dosage;
  final String freq;
  final String time;
  final bool taken;
  final med;

  const MedicineCard({
    super.key,
    required this.id,
    required this.name,
    required this.dosage,
    required this.freq,
    required this.time,
    this.taken = false,
    required this.med,
  });

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  late bool _isTaken;
  final _medService = MedicationService();

  @override
  void initState() {
    super.initState();
    _isTaken = widget.taken;
  }

  // Handle marking as taken
  Future<void> _markAsTaken() async {
    try {
      await _medService.markMedicationAsTaken(widget.id);
      setState(() {
        _isTaken = true;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to mark as taken: $e')));
      }
    }
  }

  // Handle edit
  void _onEdit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddEditMedicationScreen(existingMedication: widget.med),
      ),
    );
  }

  // Handle delete
  Future<void> _onDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Medication?'),
        content: Text('Are you sure you want to delete "${widget.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _medService.deleteMedication(widget.id);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Medication deleted')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to delete: $e')));
        }
      }
    }
  }

  // Handle tap
  void _onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicationDetailsScreen(medication: widget.med),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isTaken) {
          _onTap();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: _isTaken
              ? Colors.grey.shade200
              : Color(AppColor.textSecondary),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _isTaken ? Colors.grey : Color(AppColor.primary),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left icon box
            Container(
              width: 50.w,
              height: 55.h,
              decoration: BoxDecoration(
                color: _isTaken
                    ? Colors.grey.shade300
                    : Color(AppColor.primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.medication_outlined,
                color: _isTaken ? Colors.grey : Color(AppColor.primary),
                size: 28.sp,
              ),
            ),
            SizedBox(width: 10.w),

            // Middle content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _isTaken
                          ? Colors.grey
                          : Color(AppColor.medicationColor),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      decoration: _isTaken ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    widget.dosage,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: _isTaken ? Colors.grey : Color(AppColor.textHint),
                      decoration: _isTaken ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: _isTaken
                            ? Colors.grey
                            : Color(AppColor.textHint),
                        size: 12.sp,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          '${widget.freq} Â· ${widget.time}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: _isTaken
                                ? Colors.grey
                                : Color(AppColor.textHint),
                            decoration: _isTaken
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Right-side icons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: _isTaken ? null : _markAsTaken,
                  icon: Icon(
                    _isTaken
                        ? Icons.check_circle
                        : Icons.check_circle_outline_rounded,
                    color: _isTaken ? Colors.grey : Color(AppColor.doneChoose),
                    size: 22.sp,
                  ),
                ),
                IconButton(
                  onPressed: !_isTaken ? _onEdit : null,
                  icon: Icon(
                    Icons.edit_document,
                    color: !_isTaken ? Color(AppColor.primary) : Colors.grey,
                    size: 22.sp,
                  ),
                ),
                IconButton(
                  onPressed: _onDelete,
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: !_isTaken ? Color(AppColor.red) : Colors.grey,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
