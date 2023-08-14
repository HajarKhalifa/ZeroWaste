
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:zeros/models/users.dart';

import '../../Testing/Theme/app_color.dart';
AppBar customAppbar(BuildContext context, UserCreaditials? userCreaditials) {
  return AppBar(
   elevation: 0,
    iconTheme: IconThemeData(color: Color(0xFF0D732D)),
    leading: Icon(null,),

    backgroundColor: Colors.transparent,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          colors: [
            AppColor.kPrimaryColor.withOpacity(1),
            AppColor.kAccentColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    title: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset(
            "assets/lottie/hand.json",
            height: 50.h,
            width: 50.w,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Hello!",
                style:
                TextStyle(
                  color: AppColor.kTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                userCreaditials?.fullname ?? '',
                style: TextStyle(
                  color: AppColor.kPlaceholder2,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(width: 120),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (userCreaditials?.profilePic != null)
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(userCreaditials!.profilePic!),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}



