import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Padding customTextFieldLable({
  required String lableText,
  required bool isRequired,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          lableText,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            fontStyle: FontStyle.normal,
          ),
        ),
        isRequired
            ? Text(
                "*",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              )
            : Text(""),
      ],
    ),
  );
}
