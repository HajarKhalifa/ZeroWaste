import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeros/feed/feedScreen.dart';

import '../widget/bottomnavigation/bottomappbar.dart';

class PopularPageScreen extends StatelessWidget {
  final image;
  final location;
  final title;
  final price;
  const PopularPageScreen({
    Key? key,
    required this.image,
    required this.location,
    required this.price,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(image),
                  Positioned(
                    top: 10,
                    left: 10.w,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FeedScreen()));
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              ListTile(
                leading: CircleAvatar(backgroundColor: Colors.black),
                title: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "Steps For Recycling",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(location),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Understand what can be recycled: Before you start recycling, it is important to know what can and cannot be recycled in your area. Check with your local waste management authority or recycling center to know what materials are accepted.caps. Separate different types of materials, such as plastic, metal, and glass, into their respective recycling bins.Flatten boxes and cartons: Flatten boxes and cartons to save space in your recycling bin.Do not bag recyclables: Do not put recyclable materials in plastic bags as they can get caught in the machinery during the recycling process. Instead, put them directly in the recycling bin.Recycle properly: Make sure you are recycling properly by following the instructions provided by your local recycling center or waste management authority. Improper recycling can lead to contamination and cause the entire batch of materials to be rejected.Reduce and reuse: Recycling is important, but reducing and reusing materials is even better. Try to reduce your consumption of single-use items and opt for reusable alternatives wherever possible.Spread awareness: Encourage others to recycle and spread awareness about the importance of waste reduction and proper recycling. The more people that participate, the greater the impact on the environment.",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80.0,
        color: Colors.white,
        padding: EdgeInsets.only(top: 20.0),
        child: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.white,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.red,
              bottomAppBarColor: Colors.green,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: TextStyle(
                      color: Colors
                          .grey))), // sets the inactive color of the `BottomNavigationBar`
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: 0,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.circle),
                    label: "One Piece/Price",
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Icon(Icons.circle),
                    label: "Recycle",
                    backgroundColor: Colors.black),
              ]),
        ),
      ),
    );
  }
}
