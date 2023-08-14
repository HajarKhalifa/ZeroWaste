import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:zeros/addRequest/addrequest.dart';
import 'package:zeros/gallary/gallary.dart';
import 'package:zeros/home/home.dart';
import 'package:zeros/postDetailedPage/SwapScreen.dart';
import 'package:zeros/profile/profile.dart';
import 'package:zeros/search/search.dart';
import 'package:zeros/wishlist/wishlist.dart';

List<Widget> items = [
  HomeScreen(),
  SearchScreen(),
  AddRequest(),
  SwapScreen(),
  ProfileScreen(),
];
