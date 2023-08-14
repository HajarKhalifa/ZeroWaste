import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

OutlineInputBorder customOutlineBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(200.r),
    borderSide: BorderSide(color: Colors.grey),
  );
}
