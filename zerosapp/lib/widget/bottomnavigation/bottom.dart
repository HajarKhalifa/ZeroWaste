import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeros/db/authentication/firebase_auth_methods.dart';
import 'package:zeros/provider/userProviders.dart';
import 'package:zeros/widget/customSnakeBar.dart';
import 'package:provider/provider.dart';

Widget bottom(BuildContext context, var snap) {
  var creaditials = Provider.of<UserProviders>(context).getUser;

  return InkWell(
    onTap: () async {
      String res = await FirebaseAuthMethods().addToCart(
        uid: snap!['uid'],
        requestId: snap!['requestId'],
        postPic: snap!['postURL'],
        postPrice: snap!['quantity'],
        postTitle: snap!['WasteType'],
        postLocation: snap!['Address'],
      );

      if (res == 'success') {
        // ignore: use_build_context_synchronously
        showSnakeBar("The Item is added to the wishlist.", context);
      } else {
        // ignore: use_build_context_synchronously
        showSnakeBar(res, context);
      }
    },
    child: Container(
      height: 60.h,
      width: 180.w,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          "Replace Recycle Credit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
    ),
  );
}
