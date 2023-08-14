import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

Widget menuButton({
  required String text,
  required VoidCallback press,
  String? animationAsset,
}) {
  return OutlinedButton(
    // Button styles...
    onPressed: press,
    child: Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            child: Lottie.asset(
              animationAsset ?? '',
              height: 180.h,
              width: 180.w,
            ),
          ),
          SizedBox(height: 12.h),
          // Text styles...
          text == 'Apartment'
              ? Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          )
              : Padding(
            padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF0D732D),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
