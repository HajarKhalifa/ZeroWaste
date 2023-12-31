import 'package:flutter/material.dart';
import 'package:zeros/postDetailedPage/component/body.dart';
import 'package:zeros/widget/bottomnavigation/bottomappbar.dart';
import 'package:zeros/widget/customBottomNavigation.dart';

class PostDetailedPage extends StatelessWidget {
  final snap;
  PostDetailedPage({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Body(
          snap: snap,
        ),
      ),
     /* bottomNavigationBar: bottomapp(context: context, snap: snap),*/
    );
  }
}
