import 'package:flutter/material.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ✅ responsive sizing

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onPressed;
  final BoxShape shape;
  final bool backBtn;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onPressed,
    required this.shape,
    this.backBtn = true,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(180.h),
      child: Stack(
        children: [
          // ✅ الخلفية
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/curve.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ✅ المحتوى
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ✅ زر الرجوع (اختياري)
                  if (backBtn)
                    Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 24.sp,
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                  if (backBtn) SizedBox(width: 12.w),

                  // ✅ العنوان والعنوان الفرعي
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: TextStyle(
                              color: const Color(AppColor.medicationColor),
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: TextStyle(
                              color: const Color(AppColor.medicationColor),
                              fontSize: 14.sp,
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // ✅ أيقونة الإجراء
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: shape,
                      borderRadius: shape == BoxShape.rectangle
                          ? BorderRadius.circular(12.r)
                          : null,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 24.sp,
                      icon: Icon(icon, color: Colors.black),
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(180.h);
}
