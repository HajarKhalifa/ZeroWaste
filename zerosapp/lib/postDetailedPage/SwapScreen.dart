import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zeros/Testing/Theme/app_color.dart';
import 'package:zeros/models/users.dart';
import 'package:zeros/provider/userProviders.dart';
class SwapScreen extends StatefulWidget {
  static const routeName = 'swap_screen';

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int targetPoint = 0; // Initialize with a default value

  Future<void> fetchData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();

    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data != null && data.containsKey('targetPoint')) {
      setState(() {
        targetPoint = data['targetPoint'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
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
            children: [  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Recycle",
                  style:
                  TextStyle(
                    color: AppColor.kWhiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/lottie/115250-hand-and-coin-donation-request.json",
                    height: 60,
                    width: 60,
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Credit",
                    style:
                    TextStyle(
                      color: AppColor.kWhiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Your Recycle Credit: $targetPoint',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}