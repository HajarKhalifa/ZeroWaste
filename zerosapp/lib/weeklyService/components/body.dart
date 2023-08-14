import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zeros/Testing/Theme/app_color.dart';
import 'package:zeros/constrains.dart';
import 'package:zeros/db/authentication/firestore_methods.dart';
import 'package:zeros/home/components/productHeading.dart';
import 'package:zeros/machineLearning/classifier/classifier.dart';
import 'package:zeros/machineLearning/styles.dart';
import 'package:zeros/machineLearning/widget/plant_photo_view.dart';
import 'package:zeros/models/users.dart';
import 'package:zeros/widget/customSnakeBar.dart';
import 'package:zeros/widget/default.dart';
import 'package:zeros/widget/imagepicker.dart';
import 'package:zeros/widget/validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

import '../../provider/userProviders.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  //////////////////
  TextEditingController _userstreetController = TextEditingController();
  TextEditingController _userbuildingNumberController = TextEditingController();
  TextEditingController _userApartmentNumberController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userPhonesController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();



  bool _isloading = false;
// for adding post
  String _Servecetime = "9:12PM";

  String _Servecedate = "Sunday-Tuesday-Thursday";
  void addPost({
    required final uid,
    required final userName,
    required final contactNumber,
    required final email,
  }) async {
    setState(() {
      _isloading = true;
    });
    try {
      String res = await FirestoreMethods().WasteCollection(
        Servecetime: _Servecetime,
        Servecedate: _Servecedate,
        buildingNumber: _userbuildingNumberController.text,
        uid: uid,
        username: userName,
        ApartmentNumber: _userApartmentNumberController.text,
        Name: _userNameController.text,
        street: _userstreetController.text,
        Email: _userEmailController.text,
        Phone: _userPhonesController.text,
        contactNumber: contactNumber,
        email: email,
      );
      if (res == "success") {
        setState(() {
          _isloading = false;
        });
        showSnakeBar("The reequest successfully requested.", context);
        clearPage();
      } else {
        setState(() {
          _isloading = false;
        });
        showSnakeBar(res, context);
      }
    } catch (e) {
      print("\n\n\n\tkoi error\r\r\r\r\r\n");
      print(e);
      showSnakeBar(e.toString(), context);
    }
  }

  clearPage() {
    setState(() {
      _userPhonesController.text = "";
      _userEmailController.text = "";
      _userstreetController.text = "";
      _userNameController.text = "";
      _userApartmentNumberController.text = "";
      _userbuildingNumberController.text = "";
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userPhonesController.dispose();
    _userEmailController.dispose();
    _userstreetController.dispose();
    _userNameController.dispose();
    _userbuildingNumberController.dispose();
    _userApartmentNumberController.dispose();
  }
  ///////////////


  @override
  Widget build(BuildContext context) {
    // provider code for gettiing the data from the databsae
    UserCreaditials? userCreaditials =
        Provider.of<UserProviders>(context).getUser;
    print(userCreaditials?.email);
    print(userCreaditials?.phoneNo);
    print(userCreaditials?.lastName);
    print(userCreaditials?.uid);

    return Padding(
      padding: EdgeInsets.all(16),
      child:   SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
        children: [


          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: productHeading(
              press: () {},
              text: "",
              title: "Chose Dates for Waste Collection Service ",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0,horizontal:0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Radio(
                              autofocus: true,
                              value: "Sunday-Tuesday-Thursday",
                              groupValue: _Servecedate,
                              onChanged: (String? value) {
                                setState(() {
                                  _Servecedate = value!;
                                });
                              },
                              activeColor: AppColor.kPrimaryColor, // Set the active color for the radio button
                            ),
                            Text(
                              "Sunday-Tuesday-Thursday",
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: AppColor.kTitle.withOpacity(0.8),
                              ),
                            ),

                          ],

                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Radio(
                              value:"Monday-Wednesday-Saturday",
                              groupValue: _Servecedate,
                              onChanged: (String? value) {
                                setState(() {
                                  _Servecedate = value!;
                                });
                              },
                              activeColor: AppColor.kPrimaryColor, // Set the active color for the radio button
                            ),
                            Text("Monday-Wednesday-Saturday",
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: AppColor.kTitle.withOpacity(0.8),
                              ),

                            ),
                          ],

                        ),



                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: productHeading(
                      press: () {},
                      text: "",
                      title: "Chose Range Time for Waste Collection Service",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Radio(
                          autofocus: true,
                          value: "9:12PM",
                          groupValue: _Servecetime,
                          onChanged: (String? value) {
                            setState(() {
                              _Servecetime = value!;
                            });
                          },
                          activeColor: AppColor.kPrimaryColor, // Set the active color for the radio button
                        ),
                        Text(
                          "9:12PM",
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColor.kTitle.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(
                          width: 48.w,
                        ),
                        Radio(
                          value:"3:6Am",
                          groupValue: _Servecetime,
                          onChanged: (String? value) {
                            setState(() {
                              _Servecetime = value!;
                            });
                          },
                          activeColor: AppColor.kPrimaryColor, // Set the active color for the radio button
                        ),
                        Text("3:6Am",
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColor.kTitle.withOpacity(0.8),
                          ),

                        ),
                      ],
                    ),
                  ),





                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(),
                  productHeading(
                    press: () {},
                    text: "",
                    title: "Personal Information",
                  ),
                  SizedBox(height: 8,),
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: AppColor.kPrimaryColor,
                      textInputAction: TextInputAction.next,
                      validator: requiredField,
                      controller: _userNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        focusColor: AppColor.kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.kPrimaryColor),
                        ),
                        filled: true,
                        fillColor: AppColor.kPlaceholder2,
                        hintText: "Please enter your Name",
                        labelText: 'Name',
                        labelStyle:  TextStyle(fontSize: 18, color: AppColor.kPrimaryColor),
                        hintStyle: TextStyle(fontSize: 14, color: AppColor.kTextColor3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hoverColor: AppColor.kPrimaryColor,
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Display label above the box
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18), // Padding for the hint text
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 28.h,
                  ),
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: AppColor.kPrimaryColor,
                      textInputAction: TextInputAction.next,
                      validator: requiredField,
                      controller: _userPhonesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusColor: AppColor.kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.kPrimaryColor),
                        ),
                        filled: true,
                        fillColor: AppColor.kPlaceholder2,
                        hintText: "Please enter your Phone Number",
                        labelText: 'Phone Number',
                        labelStyle:  TextStyle(fontSize: 18, color: AppColor.kPrimaryColor),
                        hintStyle: TextStyle(fontSize: 14, color: AppColor.kTextColor3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hoverColor: AppColor.kPrimaryColor,
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Display label above the box
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18), // Padding for the hint text
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 28.h,
                  ),
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: AppColor.kPrimaryColor,
                      textInputAction: TextInputAction.next,
                      validator: requiredField,
                      controller: _userEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusColor: AppColor.kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.kPrimaryColor),
                        ),
                        filled: true,
                        fillColor: AppColor.kPlaceholder2,
                        hintText: "Please enter your Email",
                        labelText: 'Email',
                        labelStyle:  TextStyle(fontSize: 18, color: AppColor.kPrimaryColor),
                        hintStyle: TextStyle(fontSize: 14, color: AppColor.kTextColor3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hoverColor: AppColor.kPrimaryColor,
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Display label above the box
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18), // Padding for the hint text
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: AppColor.kPrimaryColor,
                      textInputAction: TextInputAction.next,
                      validator: requiredField,
                      controller: _userstreetController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusColor: AppColor.kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.kPrimaryColor),
                        ),
                        filled: true,
                        fillColor: AppColor.kPlaceholder2,
                        hintText: "Please enter Street Name",
                        labelText: 'Street Name',
                        labelStyle:  TextStyle(fontSize: 18, color: AppColor.kPrimaryColor),
                        hintStyle: TextStyle(fontSize: 14, color: AppColor.kTextColor3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hoverColor: AppColor.kPrimaryColor,
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Display label above the box
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18), // Padding for the hint text
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: AppColor.kPrimaryColor,
                      textInputAction: TextInputAction.next,
                      validator: requiredField,
                      controller: _userbuildingNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusColor: AppColor.kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.kPrimaryColor),
                        ),
                        filled: true,
                        fillColor: AppColor.kPlaceholder2,
                        hintText: "Please enter the Building Number",
                        labelText: 'Building Number',
                        labelStyle:  TextStyle(fontSize: 18, color: AppColor.kPrimaryColor),
                        hintStyle: TextStyle(fontSize: 14, color: AppColor.kTextColor3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hoverColor: AppColor.kPrimaryColor,
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Display label above the box
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18), // Padding for the hint text
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 28.h,
                  ),
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: AppColor.kPrimaryColor,
                      textInputAction: TextInputAction.next,
                      validator: requiredField,
                      controller: _userApartmentNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusColor: AppColor.kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.kPrimaryColor),
                        ),
                        filled: true,
                        fillColor: AppColor.kPlaceholder2,
                        hintText: "Please enter the Apartment Number",
                        labelText: 'Apartment Number',
                        labelStyle:  TextStyle(fontSize: 18, color: AppColor.kPrimaryColor),
                        hintStyle: TextStyle(fontSize: 14, color: AppColor.kTextColor3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hoverColor: AppColor.kPrimaryColor,
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Display label above the box
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18), // Padding for the hint text
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  _isloading
                      ? CupertinoActivityIndicator() :
                     defaultButton(
                          text: "Go Green",
                          press: () async {
                            if (!_formKey.currentState!.validate()) {
                              // If the form is not valid, display a snackbar. In the real world,

                            } else {
                              print("button clicked");
                              // UserCreaditials? _users;
                              // final FirebaseAuthMethods _auth = FirebaseAuthMethods();
                              // UserCreaditials userCreaditials =
                              //     await _auth.getUserDetails();

                              addPost(
                                uid: userCreaditials?.uid,
                                email: userCreaditials?.email,
                                userName: userCreaditials?.fullname,
                                contactNumber: userCreaditials?.phoneNo,
                              );
                            }
                          }),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }












}
