import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeros/Testing/Theme/app_color.dart';

Row productHeading({
  required String title,
  required String text,
  required VoidCallback press,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color:AppColor.kTitle.withOpacity(0.6),
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      TextButton(
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(color: Colors.green),
        ),
      ),
    ],
  );
}
