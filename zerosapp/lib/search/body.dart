
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zeros/house/house.dart';
import 'package:zeros/search/menuHouses.dart';

import 'package:provider/provider.dart';

import '../../provider/userProviders.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  addData() async {
    UserProviders userProviders = Provider.of(context, listen: false);

    await userProviders.refreshUser();
  }

  Position? _currentPosition;
  String? _currentAddress;
  final Geolocator geolocator = Geolocator();


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(

        children: [


          SizedBox(
            height: 20.h,
          ),

          Column(
            children: [

              SizedBox(height: 1.h),
              menuButton(
                animationAsset: 'assets/lottie/77856-select-your-location.json',

                text: 'Branch',
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HouseScreen(
                      pageInfo: 'Branch',
                    ),
                  ));
                },

              ),

              SizedBox(
                height: 7.h,
              ),
              menuButton(
                animationAsset: 'assets/lottie/90409-delivery-truck.json',

                text: "Door To Door",
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HouseScreen(
                        pageInfo: "Door To Door",
                      ),
                    ),
                  );
                },
              ),



            ],
          ),


        ],
      ),
    );
  }
}
