import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeros/Testing/ui/screens/tab/charity/step_four_screen.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import '../../../widgets/charity/charity_scaffold.dart';
import '../../../widgets/charity/steps.dart';

class StepThreeScreen extends StatefulWidget {
  static var routeName = '/step_three_screen';
  final String image;
  final String type;
  final TextEditingController quantityController;
  final TextEditingController totalPointsController;

   StepThreeScreen({
    required this.image,
    required this.type,
    required this.quantityController,
    required this.totalPointsController,
  }) ;

  @override
  _StepThreeScreenState createState() => _StepThreeScreenState();
}

class _StepThreeScreenState extends State<StepThreeScreen> {
  int _selectedIndex = 0;
  late String service;

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
                    builder: (context) => StepFourScreen(
                      image: widget.image,
                      type: widget.type,
                      quantityController: widget.quantityController,
                      totalPointsController: widget.totalPointsController,
                      service: service,
                    ),
                  ),
                ),
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
      children:<Widget> [
        Text(
          'Start a Recycling',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF0D732D),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Complete The Following Steps to proceed to this Recycling program',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 12.h),
        Steps(2, 4),
        SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Our Services',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0xFF0D732D),
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0 ? Color(0xFFC8F6DB) : Color(0xFFF5F6F8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Door To Door',
                          style: TextStyle(
                            color: Color(0xFF0D732D),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1 ? Color(0xFFC8F6DB) : Color(0xFFF5F6F8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Branch',
                          style: TextStyle(
                            color: Color(0xFF0D732D),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                _selectedIndex == 0 ? service = 'You selected Door To Door Service' : _selectedIndex == 1 ? service = 'You selected Branch Service' : '',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColor.kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
