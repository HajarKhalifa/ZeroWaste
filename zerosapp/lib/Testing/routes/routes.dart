import 'package:flutter/material.dart';
import 'package:zeros/Testing/ui/screens/tab/charity/start_charity_screen.dart';
import 'package:zeros/Testing/ui/screens/tab/charity/step_four_screen.dart';
import 'package:zeros/Testing/ui/screens/tab/charity/step_one_screen.dart';
import 'package:zeros/Testing/ui/screens/tab/charity/step_three_screen.dart';
import 'package:zeros/Testing/ui/screens/tab/charity/step_two_screen.dart';
class RouteGenerator {
  static const String startCharity = '/start_charity_screen';
  static const String stepOne = '/step_one_screen';
  static const String stepTwo = '/step_two_screen';
  static const String stepThree = '/step_three_screen';
  static const String stepFour = '/step_four_screen';
  RouteGenerator._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startCharity:
        return MaterialPageRoute(
          builder: (_) => StartCharityScreen(),
        );
      case stepOne:
        return MaterialPageRoute(
          builder: (_) => StepOneScreen(),
        );
      case stepTwo:
        return MaterialPageRoute(
          builder: (_) => StepTwoScreen(image: '', type: '',),
        );
      case stepThree:
        return MaterialPageRoute(
          builder: (_) => StepThreeScreen(image: '', type: '',quantityController: TextEditingController(), totalPointsController:  TextEditingController(),),
        );
      case stepFour:
        return MaterialPageRoute(
          builder: (_) => StepFourScreen(image: '', type: '', quantityController: TextEditingController(), totalPointsController:  TextEditingController(), service: '', ),
        );
      default:
        throw RouteException('Route not found');
    }
  }
}
class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}
