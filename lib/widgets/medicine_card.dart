import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medilink/core/constant/appcolor.dart';

class MedicineCard extends StatelessWidget {
  final String name;
  final String dosage;
  final String freq;
  final String time;
  final VoidCallback? onDone;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const MedicineCard({
    super.key,
    required this.name,
    required this.dosage,
    required this.freq,
    required this.time,
    this.onDone,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ✅ Let parent decide what happens on tap
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Color(AppColor.textSecondary),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Color(AppColor.primary)),
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
                color: Color(AppColor.primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.medication_outlined,
                color: Color(AppColor.primary),
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
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(AppColor.medicationColor),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    dosage,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(AppColor.textHint),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Color(AppColor.textHint),
                        size: 12.sp,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          '$freq · $time',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(AppColor.textHint),
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
                  onPressed: onDone,
                  icon: Icon(
                    Icons.check_circle_outline_rounded,
                    color: Color(AppColor.doneChoose),
                    size: 22.sp,
                  ),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    Icons.edit_document,
                    color: Color(AppColor.primary),
                    size: 22.sp,
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Color(AppColor.red),
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
