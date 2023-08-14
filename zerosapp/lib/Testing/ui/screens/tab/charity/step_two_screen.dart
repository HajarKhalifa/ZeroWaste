import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeros/Testing/routes/routes.dart';
import 'package:zeros/Testing/theme/app_color.dart';
import 'package:zeros/Testing/ui/screens/tab/charity/step_three_screen.dart';
import 'package:zeros/Testing/ui/widgets/charity/charity_input_field.dart';
import 'package:zeros/Testing/ui/widgets/charity/charity_scaffold.dart';
import 'package:zeros/Testing/ui/widgets/charity/steps.dart';

class StepTwoScreen extends StatelessWidget {
  static var routeName = '/step_two_screen';

  final String image;
   final String type;

  StepTwoScreen({required this.image, required this.type});

  TextEditingController _quantityController = TextEditingController();

  TextEditingController _totalPointsController = TextEditingController();

  void calculateTotalPoints() {

    int quantity = int.tryParse(_quantityController.text) ?? 0;
    int point;
   /* if (type == 'Plastic') {
      point = 4;
      print(type);
    } else if (type == 'Metal') {
      point = 8;
    } else if (type == 'Glass') {
      point = 16;
    } else {
      point = 0; // Default value if the type is not recognized
    }*/
    point=4;
    int totalPoints = quantity * point;
    _totalPointsController.text = totalPoints.toString();
  }

  @override
  Widget build(BuildContext context) {
    return CharityScaffold(
      button: Container(
        decoration: BoxDecoration(
          color: AppColor.kPlaceholder1.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    AppColor.kPlaceholder1,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Previous'),
              ),
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    AppColor.kAccentColor,
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    AppColor.kPrimaryColor,
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StepThreeScreen(
                      image: image,
                      type: type,
                      quantityController: _quantityController,
                      totalPointsController: _totalPointsController,
                    ),
                  ),
                ),
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
      children: [
        Text(
          'Start a Recycling',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF0D732D),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Text(
          'Complete The Following Steps to proceed to this Recycling program',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 24.h,
        ),
        Steps(1, 4),

        Expanded(
          child: TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Quantity',
            ),
            onChanged: (value) {
              calculateTotalPoints();
            },
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Type Of Waste: Plastic'),
            ],
          ),
        ),
        Expanded(
          child: TextField(
            controller: _totalPointsController,
            decoration: InputDecoration(
              labelText: 'Total Points',
            ),
            readOnly: true,
          ),
        ),
      ],
    );
  }
}
