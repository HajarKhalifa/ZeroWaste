import 'package:flutter/material.dart';

import 'package:zeros/models/users.dart';
import 'package:zeros/provider/userProviders.dart';
import 'package:zeros/search/appbar.dart';
import 'package:zeros/search/body.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/SearchScreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),

      body: Body(),
    );
  }
}
