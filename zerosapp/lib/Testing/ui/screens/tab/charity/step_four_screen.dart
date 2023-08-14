import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeros/Testing/theme/app_color.dart';
import 'package:zeros/home/home.dart';
import '../../../widgets/charity/charity_scaffold.dart';
import '../../../widgets/charity/steps.dart';

class StepFourScreen extends StatefulWidget {
  static var routeName = '/step_four_screen';
  final String image;
  final String type;
  final TextEditingController quantityController;
  final TextEditingController totalPointsController;
  final String service;

  StepFourScreen({
    required this.service,
    required this.image,
    required this.type,
    required this.quantityController,
    required this.totalPointsController,
  });

  @override
  State<StepFourScreen> createState() => _StepFourScreenState();
}

class _StepFourScreenState extends State<StepFourScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CharityScaffold(
      children: <Widget>[
        Text(
          'Start a Recycling',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF0D732D),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Complete your personal information to proceed to this Recycling program',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 12.h),
        Steps(3, 4),
        SizedBox(
          height: 24.h,
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            onChanged: (value) {},
            controller: nameController,
          ),
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            controller: emailController,
          ),
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Phone',
            ),
            controller: phoneController,
          ),
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Address',
            ),
            controller: addressController,
          ),
        ),
      ],
      button:
      ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          foregroundColor: MaterialStateProperty.all(AppColor.kPlaceholder2),
          backgroundColor: MaterialStateProperty.all(AppColor.kAccentColor),
          elevation: MaterialStateProperty.all(0),
          minimumSize: MaterialStateProperty.all(
            Size(double.infinity, 48.h),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 24.w),
          ),
        ),
        onPressed: () {
          _submitData();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.r),
            ),
            builder: (_) => _buildSuccessModalSheet(context),
          );
        },
        child: Text('Get Now'),
      ),

    );
  }

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = nameController.text;
    final email = emailController.text;
    final phone = phoneController.text;
    final address = addressController.text;
    final image = widget.image;
    final type = widget.type;
    final service = widget.service;


    // Save data to Firestore
    final collectionRef = FirebaseFirestore.instance.collection('RecycleRequest');
    await collectionRef.add({
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'image': image,
      'type': type,
      'service':service,
    });

    // Upload image to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');
    await storageRef.putFile(File(image));

    // Show success modal bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.r),
      ),
      builder: (_) => _buildSuccessModalSheet(context),
    );
  }

  Widget _buildSuccessModalSheet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewPadding.bottom,
        top: 32.h,
        left: 16.w,
        right: 16.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 64.h,
          ),
          SvgPicture.asset(
            'assets/images/check.svg',
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            'Successful',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.kPrimaryColor,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            'Your Recycling program has been successfully created. '
                'You can now check and maintain it in the "Activity" menu.',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 80.h,
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              foregroundColor: MaterialStateProperty.all(AppColor.kPlaceholder2),
              backgroundColor: MaterialStateProperty.all(AppColor.kAccentColor),
              elevation: MaterialStateProperty.all(0),
              minimumSize: MaterialStateProperty.all(
                Size(double.infinity, 48.h),
              ),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 24.w),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text('Home'),
          ),
        ],
      ),
    );
  }
}
