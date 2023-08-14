import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zeros/Testing/Theme/app_color.dart';
import 'package:zeros/feed/global_variables.dart';

import '../widget/floatingActionButton.dart';

class FeedScreen extends StatefulWidget {
  static String routeName = "/feedScreen";

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageController = PageController();
  }

  // creating the page controlller
  late PageController pageController;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  int _page = 0;
  selectedTab(int selectedPage) {
    pageController.jumpToPage(selectedPage);
  }

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: items,
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
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
        child: SafeArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  selectedTab(0);
                });
              },
              icon: Icon(
                FontAwesomeIcons.home,
                color: _page == 0
                    ? AppColor.kPlaceholder2.withOpacity(0.5)
                    : AppColor.kPlaceholder1,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedTab(3);
                });
              },
              icon: Icon(
                FontAwesomeIcons.gift,
                color: _page == 3
                    ? AppColor.kPlaceholder2.withOpacity(0.5)
                    : AppColor.kPlaceholder1,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedTab(2);
                });
              },
              icon: Icon(
                FontAwesomeIcons.recycle,
                color: _page == 1
                    ? AppColor.kPlaceholder2.withOpacity(0.5)
                    : AppColor.kPlaceholder1,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedTab(1);
                });
              },
              icon: Icon(
                FontAwesomeIcons.moneyBillTransfer,
                color: _page == 1
                    ? AppColor.kPlaceholder2.withOpacity(0.5)
                    : AppColor.kPlaceholder1,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedTab(4);
                });
              },
              icon: Icon(
                  FontAwesomeIcons.user,
                  color: _page == 4
                      ? AppColor.kPlaceholder2.withOpacity(0.5)
                      : AppColor.kPlaceholder1,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
