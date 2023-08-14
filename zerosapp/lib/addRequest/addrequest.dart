import 'package:flutter/material.dart';
import 'package:zeros/addRequest/components/body.dart';
import 'package:zeros/addRequest/components/appbar.dart';

class AddRequest extends StatelessWidget {
  static var routeName='/AddRequest';

  const AddRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: Body(),
    );
  }
}
