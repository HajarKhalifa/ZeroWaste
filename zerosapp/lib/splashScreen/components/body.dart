import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeros/splashScreen/components/splashstats.dart';
import 'package:zeros/splashScreen/components/splastDots.dart';

import '../../signin/signin.dart';
import '../../widget/default.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 0;

  List<Map<String, String>> items = [
    {
      "title": "Welcome to our Recycling App!",
      "desc":
          "With our app, you can turn your waste into money while helping the environment. Let's get started by creating an account.",
      "imageURL": "assets/images/Frame2.png"  ,
    },
    {
      "title": "Take a Photo of Your Waste",
      "desc":
      "To get started, simply take a photo of your waste using your phone's camera. Our app will identify the type of waste and provide you with a quote for how much money you can earn by recycling it.",


      "imageURL": "assets/images/Group2.png",
    },

    {
      "title": " Drop off Your Waste and Get Paid",
      "desc":
      "The app encourages users to recycle by allowing them to drop off waste at partner recycling centers and receive payments directly to their account after accepting a quote, promoting environmental protection.",


      "imageURL": "assets/images/Frame.png",
    },
    {
      "title": " Track Your Progress",
      "desc":
      " As you recycle with our app, you can track your progress and see how much waste you've diverted from landfills. Keep up the great work and join our community of eco-conscious individuals making a difference!",

      "imageURL": "assets/images/Group.png",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: items.length,
                itemBuilder: (context, index) => splashStats(
                  title: items[index]["title"].toString(),
                  desc: items[index]["desc"].toString(),
                  imageURL: items[index]["imageURL"].toString(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      items.length,
                      (index) =>
                          splashDots(index: index, currentIndex: currentIndex),
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  currentIndex == 3
                      ? Container()
                      : TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Signin.routeName);
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              color: Color(0xff023020),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: currentIndex == 3
                        ? defaultButton(
                            press: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(Signin.routeName);
                            },
                            text: "Log in")
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.green[900],
                                shape: StadiumBorder(),
                                padding: EdgeInsets.all(12),
                                minimumSize: Size(double.infinity, 40.h),
                              ),
                              onPressed: null,
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
