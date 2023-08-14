
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:zeros/Testing/ui/screens/tab/charity/start_charity_screen.dart';
import 'package:zeros/Testing/theme/app_color.dart';
import 'package:zeros/addRequest/addrequest.dart';
import 'package:zeros/home/components/menuHouses.dart';
import 'package:zeros/home/components/productHeading.dart';
import 'package:zeros/house/house.dart';
import 'package:zeros/popularPage/popularHouse.dart';
import 'package:provider/provider.dart';
import 'package:zeros/postDetailedPage/SwapScreen.dart';
import 'package:zeros/submitOnceTest/submitting.dart';
import 'package:zeros/weeklyService/weeklyService.dart';
import '../../Testing/ui/widgets/category.dart';
import '../../provider/userProviders.dart';
import '../../widget/customCard.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double progressValueC = 0.0; // Initialize with a default value
  bool isLoading = false;
  int targetPoint = 0; // Initialize with a default value
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();

    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data != null && data.containsKey('targetPoint')) {
      int fetchedTargetPoint = data['targetPoint'];
      double fetchedProgressValueC = double.parse(data['progressValueC']);

      if (fetchedTargetPoint > 1000) {
        progressValueC = fetchedTargetPoint - 1000;
      } else {
        progressValueC = fetchedTargetPoint * 1;
      }
    }
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });

    await fetchData(); // Fetch updated data from Firebase

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  addData() async {
    UserProviders userProviders = Provider.of(context, listen: false);

    await userProviders.refreshUser();
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? Center(child: CupertinoActivityIndicator())
          :RefreshIndicator(
    onRefresh: refreshData,
    child:  // Call refreshData when swiping down
 Padding(
    padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.h),
        child: SingleChildScrollView(

          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child:
                Container(
                  width: double.infinity,
                  height: 120.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.kPrimaryColor.withOpacity(1),

                        AppColor.kAccentColor.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/mask_diamond.svg',
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Change The World With',
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),

                            ),
                            Text(
                              'Your Little Help',
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
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
                              onPressed: () {
                                Navigator.of(context).pushNamed(AddRequest.routeName);
                              },
                              child: Text(
                                'Recycle',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),



              Category(),
              Divider(),
              Padding(
                padding: EdgeInsets.all(5),
                child:
                Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.kPlaceholder2.withOpacity(1),

                        AppColor.kPlaceholder2.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  child:
                  Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/mask_diamond.svg',
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '$progressValueC R.C',
                                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                          color: AppColor.kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Collected',
                                        style: TextStyle(
                                          color: AppColor.kTextColor3,
                                        ),
                                      ),

                                    ],

                                  ),
                                  CircularPercentIndicator(
                                    radius: 75.0,
                                    lineWidth: 12.0,
                                    percent: (progressValueC % 1000).clamp(0, 1000) / 1000, // Divide by 1000 to get a value between 0.0 and 1.0
                                    center: Text("${((progressValueC % 1000) / 10).toStringAsFixed(0)}%"),
                                    progressColor: AppColor.kPrimaryColor,
                                  ),

                                  Column(
                                    children: [

                                      Row(
                                        children: [
                                          Text(
                                            '1000 R.C',
                                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                              color: AppColor.kPrimaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Target',
                                        style: TextStyle(
                                          color: AppColor.kTextColor3,
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
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
                              onPressed: () {
                                Navigator.of(context).pushNamed(SwapScreen.routeName);
                              },
                              child: Text(
                                'Recycle Credit',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (progressValueC >= 1000) ...[

                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () {

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Congratulations!'),
                                  content: Text('You have reached the target value.'),
                                  actions: [
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
                                      child: Text(
                                        'OK',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () async {

                                          progressValueC -= 1000;
                                          targetPoint += 100;
                                        Navigator.of(context).pop();
                                        String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

                                        DocumentReference userDocRef = _firestore.collection('users').doc(currentUserUid);

                                        // Save updated targetPoint and progressValueC to Firebase
                                        await _firestore.runTransaction((transaction) async {
                                          DocumentSnapshot userSnapshot = await transaction.get(userDocRef);
                                          int currentTargetPoint = int.tryParse(userSnapshot.get('targetPoint') ?? "") ?? 0;
                                          int newTargetPoint = currentTargetPoint + targetPoint;
                                          setState(() {
                                            transaction.update(userDocRef, {
                                              'targetPoint': newTargetPoint.toString(),
                                            });

                                          });
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),


                ),
              ),
              productHeading(
                press: () {},
                text: "",
                title: "Weekly Waste Collection Service",
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child:
                Container(
                  width: double.infinity,
                  height: 120.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.kPrimaryColor.withOpacity(1),

                        AppColor.kAccentColor.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/mask_diamond.svg',
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Greener Future With ',
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),

                            ),
                            Text(
                              ' Our hassle-free Weekly ',
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),

                            ),

                            Text(
                              ' Waste Collection Service',
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
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
                              onPressed: () {
                                Navigator.of(context).pushNamed(weeklyService.routeName);
                              },
                              child: Text(
                                'Join Service',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              productHeading(
                press: () {},
                text: "",
                title: "Recycle Credit",
              ),
              Container(

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.kPlaceholder2.withOpacity(1),

                        AppColor.kPlaceholder2.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                child: Table(

                  border: TableBorder.all(
                    color: Colors.transparent, // Set the border color here
                    width: 2.0,
                  ),
                  children: [
                    TableRow(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        gradient: LinearGradient(
                          colors: [
                            AppColor.kPrimaryColor.withOpacity(1),
                            AppColor.kAccentColor.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),

                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                  'Units',
                                style:
                                TextStyle(
                                  color: AppColor.kWhiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),

                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Material',
                                style:
                                TextStyle(
                                  color: AppColor.kWhiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),

                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                  'Recycle Credit',
                                style:
                                TextStyle(
                                  color: AppColor.kWhiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],

                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Unit'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Plastic'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('4 R.C'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Unit'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Metal'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('8 R.C'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Unit'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Glass'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('16 R.C'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Kg'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Paper'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('24 R.C'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Kg'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Cardboard'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('8 R.C'),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),

              SizedBox(
                height: 16.h,
              ),





            ],
          ),
        ),
      ),
      ),
    );
  }
}
