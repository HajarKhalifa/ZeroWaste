import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeros/smsOTP/components/body.dart';

class SmsOtpScreen extends StatelessWidget {
  static String routeName = "/smsOTPScreen";
  final int value;
  SmsOtpScreen({required this.value});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF0D732D)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: Color(0xFF0D732D),
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Body(
        value: value,
      ),
    );
  }
}
