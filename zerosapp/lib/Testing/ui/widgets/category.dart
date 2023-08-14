import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeros/machineLearning/styles.dart';

import '../../theme/app_color.dart';

final List<String> categories = [
  'Plastic',
  'Metal',
  'Glass',
  'Paper',
  'Cardboard',
];

class Category extends StatefulWidget {
  const Category({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int selectedCat = 0;

  void showRecycleStepsDialog(String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Recycling Instructions for $category',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppColor.kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#1 First Step\nEmpty and rinse the $category container.',
                ),
                Divider(),
                Text(
                  '#2 Second Step\nCheck the recycling symbol on the container to identify the type of $category.',
                ),
                Divider(),
                if (category == 'Paper' || category == 'Cardboard')
                  ...[
                    Text(
                      '#3 Third Step\nFlatten any cardboard boxes to save space. Large pieces of cardboard can be cut into smaller sizes if needed.',
                    ),
                    Divider(),
                    Text(
                      '#4 Fourth Step\nSeparate $category into different recycling bins or designated areas. Follow the guidelines provided if specific sorting is required.',
                    ),
                    Divider(),
                    Text(
                      '#5 Fifth Step\nPlace the $category in your designated recycling bin until the collector arrives or take it to a recycling center.',
                    ),
                    Divider(),
                    Text(
                      '#6 Sixth Step\nFollow your local recycling guidelines for rewards.',
                    ),
                    Divider(),
                  ],
                if (category != 'Paper' && category != 'Cardboard')
        ...[
                  Text(
                    '#3 Third Step\nSeparate different types of $category if necessary.',
                  ),
                Divider(),
                Text(
                  '#4 Fourth Step\nFlatten or crush the $category to save space.',
                ),
                Divider(),
                Text(
                  '#5 Fifth Step\nPlace the $category in your designated recycling bin until the collector arrives or take it to a recycling center.',
                ),
                Divider(),
                Text(
                  '#6 Sixth Step\nFollow your local recycling guidelines for rewards.',
                ),
                Divider(),
              ],
        ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: AppColor.kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        height: 35.h,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              categories.length,
                  (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCat = index;
                  });
                  showRecycleStepsDialog(categories[index]);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 30.w,
                      ),
                      decoration: BoxDecoration(
                        color: selectedCat == index
                            ? AppColor.kPrimaryColor
                            : AppColor.kPlaceholder2,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCat == index
                              ? Colors.white
                              : AppColor.kTextColor3,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
