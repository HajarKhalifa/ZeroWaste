import 'package:flutter/material.dart';

import '../weeklyService/components/body.dart';
import '../weeklyService/components/appbar.dart';


class weeklyService extends StatelessWidget {
  static var routeName='/weeklyService';

  const weeklyService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: Body(),
    );
  }
}
