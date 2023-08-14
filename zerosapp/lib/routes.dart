import 'package:flutter/material.dart';
import 'package:zeros/addRequest/addrequest.dart';
import 'package:zeros/chat/chat.dart';
import 'package:zeros/feed/feedScreen.dart';
import 'package:zeros/home/home.dart';
import 'package:zeros/lottie/splash.dart';
import 'package:zeros/map/location.dart';
import 'package:zeros/map/mapscreen.dart';
import 'package:zeros/postDetailedPage/SwapScreen.dart';
import 'package:zeros/search/search.dart';
import 'package:zeros/signin/signin.dart';
import 'package:zeros/signup/signup.dart';
import 'package:zeros/smsOTP/forgotPassword.dart';
import 'package:zeros/splashScreen/splashscreen.dart';
import 'package:zeros/submitOnceTest/submitting.dart';

import 'package:zeros/weeklyService/weeklyService.dart';
import 'Testing/test.dart';
import 'Testing/ui/screens/tab/charity/start_charity_screen.dart';
import 'Testing/ui/screens/tab/charity/step_four_screen.dart';
import 'Testing/ui/screens/tab/charity/step_one_screen.dart';
import 'Testing/ui/screens/tab/charity/step_three_screen.dart';
import 'Testing/ui/screens/tab/charity/step_two_screen.dart';
import 'chat/chat_list.dart';
import 'forgot/forgotPassword.dart';
import 'machineLearning/widget/plant_recogniser.dart';
import 'objectDetection/objectDetection.dart';

final Map<String, WidgetBuilder> routes = {
  Lottie.routeName: (context) => Lottie(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SignUp.routeName: (context) => SignUp(),
  Signin.routeName: (context) => Signin(),
  ForgotScreen.routeName: (context) => ForgotScreen(),
  SmsOTP.routeName: (context) => SmsOTP(),
  FeedScreen.routeName: (context) => FeedScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  StartCharityScreen.routeName: (context) => StartCharityScreen(),
  StepOneScreen.routeName: (context) => StepOneScreen(),
  StepTwoScreen.routeName: (context) => StepTwoScreen(image: '', type: '',),
  StepThreeScreen.routeName: (context) => StepThreeScreen(image: '', type: '', quantityController: TextEditingController(), totalPointsController:  TextEditingController(),),
  StepFourScreen.routeName: (context) => StepFourScreen(image: '', type: '', quantityController:  TextEditingController(),totalPointsController:  TextEditingController(), service: '',),
  PlantRecogniser.routeName: (context) => PlantRecogniser(),
  ObjectDetection.routeName: (context) => ObjectDetection(),
  SearchScreen.routeName: (context) => SearchScreen(),
  AddRequest.routeName: (context) => AddRequest(),
  MapScreen.routeName: (context) => MapScreen(),
  LocationScreen .routeName: (context) => LocationScreen(),
  FirstScreen .routeName: (context) => FirstScreen(),

  RecyclingScreen .routeName: (context) => RecyclingScreen(),
  SwapScreen .routeName: (context) => SwapScreen(),
  weeklyService .routeName: (context) => weeklyService(),
  UserChatPage .routeName: (context) => UserChatPage(todoItemId: '',),
  ChatListScreen .routeName: (context) => ChatListScreen(),



















};
