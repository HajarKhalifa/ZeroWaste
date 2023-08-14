import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zeros/Testing/Theme/app_color.dart';
import 'package:zeros/models/posts.dart';
import 'package:zeros/postDetailedPage/SwapScreen.dart';
import 'package:zeros/widget/validator.dart';

class Body extends StatefulWidget {
  final snap;
  Body({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _userCIdController = TextEditingController();

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Collect Your Recycle Credit'),
          content: TextFormField(
            cursorColor: AppColor.kPrimaryColor,
            textInputAction: TextInputAction.next,
            validator: requiredField,
            controller: _userCIdController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              focusColor: AppColor.kPrimaryColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.kPrimaryColor),
              ),
              filled: true,
              fillColor: AppColor.kPlaceholder2,
              hintText: "Please enter CleanerID",
              labelText: 'CleanerID',
              labelStyle:
              TextStyle(fontSize: 18, color: AppColor.kPrimaryColor),
              hintStyle:
              TextStyle(fontSize: 14, color: AppColor.kTextColor3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hoverColor: AppColor.kPrimaryColor,
              floatingLabelBehavior:
              FloatingLabelBehavior.always, // Display label above the box
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              // Padding for the hint text
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                backgroundColor:
                MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    // When the button is pressed
                    return AppColor.kAccentColor.withOpacity(0.8);
                  } else if (states.contains(MaterialState.hovered)) {
                    // When the button is hovered
                    return AppColor.kAccentColor.withOpacity(0.9);
                  } else {
                    // Default button color
                    return AppColor.kAccentColor;
                  }
                }),
                foregroundColor: MaterialStateProperty.all(
                  AppColor.kThirdColor,
                ),
              ),
              onPressed: () async {
                String userCId = _userCIdController.text.trim();
                String requestId = widget.snap!["requestId"];
                String requestCode = widget.snap!["requestCode"];


                if (userCId == requestCode) {
                  bool aactivation = widget.snap!["Aactivation"] ?? true;

                  if (!aactivation) {
                    // Show a short dialog if Aactivation is false
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Sorry!'),
                          content: Text('Already Used'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    int totalPoint = int.tryParse(widget.snap?["totalPoint"] ?? "") ?? 0;
                    int targetPoint = int.tryParse(widget.snap?["targetPoint"] ?? "") ?? 0;

                    // Increment the targetPoint value by the totalPoint value
                    targetPoint += totalPoint;

                    // Update the targetPoint value in the database
                    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
                    DocumentReference userDocRef = _firestore.collection('users').doc(currentUserUid);
                    DocumentReference requestDocRef = _firestore.collection('requests').doc(requestId);

                    await _firestore.runTransaction((transaction) async {
                      DocumentSnapshot userSnapshot = await transaction.get(userDocRef);
                      int currentTargetPoint = userSnapshot.get('targetPoint') ?? 0;
                      int newTargetPoint = currentTargetPoint + targetPoint;

                      transaction.update(userDocRef, {'targetPoint': newTargetPoint});
                      transaction.update(requestDocRef, {'Aactivation': false});
                    });

                    // Update the targetPoint value in the widget
                    setState(() {
                      widget.snap!["targetPoint"] = targetPoint.toString();
                      widget.snap!["Aactivation"] = false;
                    });
                    // The IDs match, navigate to SwapScreen
                    Navigator.of(context).pop();
                  }
                } else {
                  // The IDs don't match, show an alert
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid CleanerID'),
                        content: Text('Please enter the correct CleanerID.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                'Submit',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserRequest userRequest = UserRequest.fromSnap(widget.snap);
    bool isActive = userRequest.Aactivation;
    return SingleChildScrollView(
      child: Column(children: [
        Stack(
          children: [
            Container(
              height: 300.h,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: widget.snap!["postURL"],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.green)),
                      child:
                      Text(
                        widget.snap!["ServeceStatus"],
                        style: TextStyle(color: Colors.green),
                      ),

                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.pressed)) {
                              // When the button is pressed
                              return AppColor.kAccentColor.withOpacity(0.8);
                            } else if (states.contains(MaterialState.hovered)) {
                              // When the button is hovered
                              return AppColor.kAccentColor.withOpacity(0.9);
                            } else {
                              // Default button color
                              return AppColor.kAccentColor;
                            }
                          }),
                          foregroundColor: MaterialStateProperty.all(
                            AppColor.kThirdColor,
                          ),
                        ),
                        onPressed:
                          _showInputDialog                        ,
                        child: Text(
                          'Replace Recycle Credit',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )

                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 14.h,
              ),
              Text(
                widget.snap!["WasteType"],
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(widget.snap!["Address"]),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Text(
                    userRequest.Aactivation ? "Active" : "Already Used",
                      style: TextStyle(
                        color: isActive ? Colors.green : Colors.red,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    statsHouse(
                        iconData: Icons.flag,
                        items: widget.snap!["quantity"],
                        title: "Units"),
                    statsHouse(
                        iconData: Icons.task_alt,
                        items: widget.snap!["totalPoint"],
                        title: "Recycle Credit"),

                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Divider(),
              SizedBox(
                height: 4.h,
              ),
              ListTile(
                leading: CircleAvatar(),
                title: Text(widget.snap!["userName"]),
                subtitle: Text(widget.snap!["useremail"]),
                trailing: Icon(FontAwesomeIcons.phone),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                "Overview",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                widget.snap!["overview"],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Text(widget.snap!["ServeceStatus"]),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Contact Number", style: TextStyle(fontSize: 16.sp)),
                  Text(widget.snap!["Phone"]),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        ),
      ]),
    );
  }


  Widget statsHouse({
    required IconData iconData,
    required String items,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.04),
            shape: BoxShape.circle,
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.green,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Text("$items $title"),
      ],
    );
  }
}
