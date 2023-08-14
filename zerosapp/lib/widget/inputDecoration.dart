import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeros/widget/suffixIcon.dart';

import 'customOutlineBorder.dart';

InputDecoration customInputDecoration({
  required IconData? suffixIcon,
  required String hintText,
  required VoidCallback press,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
    hintText: hintText,
    enabledBorder: customOutlineBorder(),
    suffixIcon: suffixicon(
      press: press,
      icon: suffixIcon,
      color: Color(0xFF0D732D),
    ),
    focusedBorder: customOutlineBorder(),
    border: customOutlineBorder(),
  );
}
