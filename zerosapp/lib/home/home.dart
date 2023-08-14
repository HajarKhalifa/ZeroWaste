import 'package:flutter/material.dart';
import 'package:zeros/home/components/appbar.dart';
import 'package:zeros/home/components/body.dart';
import 'package:zeros/models/users.dart';
import 'package:zeros/provider/userProviders.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/homeScreen";

  @override
  Widget build(BuildContext context) {
    UserCreaditials? userCreaditials =
        Provider.of<UserProviders>(context).getUser;

    return Scaffold(
      appBar: customAppbar(context, userCreaditials),
      body: Body(),
    );
  }
}
