import 'dart:io';
import 'dart:typed_data';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;
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

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'model_unquant.tflite';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}
enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class _BodyState extends State<Body> {
  String requestCode = '';

  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;

  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _plantLabel = ''; // Name of Error Message
  double _accuracy = 0.0;

  late Classifier _classifier;

  @override
  void initState() {
    super.initState();
    requestCode = (rand.nextInt(900000) + 100000).toString();

    _loadClassifier();
  }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
          'labels at $_labelsFileName, '
          'model at $_modelFileName',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier!;
  }

  //////////////////
  TextEditingController _userquantityController = TextEditingController();
  TextEditingController _usertotalPointController = TextEditingController();
  TextEditingController _userOverViewController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userPhonesController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userAdreesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  double priceRangeValue = 0;
  RangeValues _currentRangeValues = const RangeValues(0, 100000);

  Uint8List? _file;

  bool _isloading = false;
// for adding post
  String _WasteType = "Plastic";
  Random rand = Random();
  String _ServeceStatus = "Door To Door";
  void addPost({
    required final uid,
    required final userName,
    required final contactNumber,
    required final email,
  }) async {
    if (_WasteType == 'Plastic' || _WasteType == 'Metal' || _WasteType == 'Glass') {
      if (int.parse(_userquantityController.text) <= 10) {
        showSnakeBar('Quantity should be larger than 10 for Plastic, Metal, or Glass waste types.', context);
        return;
      }
    } else {
      if (int.parse(_userquantityController.text) < 1) {
        showSnakeBar('Quantity should be at least 1 for other waste types.', context);
        return;
      }
    }
    setState(() {
      _isloading = true;
    });
    try {
      String res = await FirestoreMethods().uploadRequest(
        ServeceStatus: _ServeceStatus,
        WasteType: _WasteType,
        file: _file!,
        quantity: _userquantityController.text,
        uid: uid,
        username: userName,
        totalPoint: _usertotalPointController.text,
        Name: _userNameController.text,
        overview: _userOverViewController.text,
        Address: _userAdreesController.text,
        Email: _userEmailController.text,
        Phone: _userPhonesController.text,
        contactNumber: contactNumber,
        email: email,
        requestCode: requestCode,

        Aactivation: true,
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
      _file = null;
      _userPhonesController.text = "";
      _userEmailController.text = "";
      _userAdreesController.text = "";
      _userOverViewController.text = "";
      _userNameController.text = "";
      _usertotalPointController.text = "";
      _userquantityController.text = "";
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userPhonesController.dispose();
    _userEmailController.dispose();
    _userAdreesController.dispose();
    _userOverViewController.dispose();
    _userNameController.dispose();
    _usertotalPointController.dispose();
    _userquantityController.dispose();
  }
  ///////////////
  void calculateTotalPoints() {

    int quantity = int.tryParse(_userquantityController.text) ?? 0;
    int point;
    if (_WasteType == 'Plastic') {
      point = 4;
      print(_WasteType);
    } else if (_WasteType == 'Metal') {
      point = 8;
    } else if (_WasteType == 'Glass') {
      point = 16;
    } else if (_WasteType == 'Paper') {
      point = 24;
    } else if (_WasteType == 'Cardboard') {
      point = 8;

    } else {
      point = 0; // Default value if the type is not recognized
    }
    int totalPoints = quantity * point;
    _usertotalPointController.text = totalPoints.toString();
  }


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
      child: SingleChildScrollView(
          child: Column(
        children: [

          Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPhotolView(),
                    ],
                  ),

                  SizedBox(
                    height: 5.h,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 33),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            _buildPickPhotoButton(
                              title: 'Pick from gallery',
                              source: ImageSource.gallery,
                            ),
                          ],
                        ),

                        SizedBox(
                          width: 12.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            _buildPickPhotoButton(
                              title: 'Take a photo',
                              source: ImageSource.camera,
                            ),
                          ],
                        ),


                        SizedBox(
                          height: 28.h,
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildResultView(),
                    ],
                  ),
                  SizedBox(height: 28.h,),

                  Container(
                    height: 40.h,
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: AppColor.kPrimaryColor,
                      textInputAction: TextInputAction.next,
                      validator: requiredField,
                      controller: _userquantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusColor: AppColor.kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.kPrimaryColor),
                        ),
                        filled: true,
                        fillColor: AppColor.kPlaceholder2,
                        hintText: "Please enter the quantity",
                        labelText: 'Quantity',
                        labelStyle:  TextStyle(fontSize: 18, color: AppColor.kPrimaryColor),
                        hintStyle: TextStyle(fontSize: 14, color: AppColor.kTextColor3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hoverColor: AppColor.kPrimaryColor,
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Display label above the box
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18), // Padding for the hint text
                      ),
                      onChanged: (value) {
                        calculateTotalPoints();
                      },
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
                      controller: _usertotalPointController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusColor: AppColor.kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.kPrimaryColor),
                        ),
                        filled: true,
                        fillColor: AppColor.kPlaceholder2,
                        hintText: "Your Recycle Credit",
                        labelText: 'Recycle Credit',
                        labelStyle:  TextStyle(fontSize: 18, color: AppColor.kPrimaryColor),
                        hintStyle: TextStyle(fontSize: 14, color: AppColor.kTextColor3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hoverColor: AppColor.kPrimaryColor,
                        floatingLabelBehavior: FloatingLabelBehavior.auto, // Display label above the box
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18), // Padding for the hint text
                      ),
                      readOnly: true,
                    ),
                  ),

                  SizedBox(
                    height: 28.h,
                  ),

                  TextFormField(
                    cursorColor: AppColor.kPrimaryColor,
                    validator: requiredField,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    controller: _userOverViewController,

                    maxLines: 8, //or null
                    decoration: InputDecoration(
                      focusColor: AppColor.kPrimaryColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColor.kPrimaryColor),
                      ),
                        border: OutlineInputBorder(
                          gapPadding: 4,
                          borderSide: BorderSide(
                            color: AppColor.kPrimaryColor,
                            width: 3,
                          ),
                        ),
                        hintText: "Enter the waste description here",
                      filled: true,
                      fillColor: AppColor.kPlaceholder2,

                      labelText: 'Description',
                      labelStyle:  TextStyle(fontSize: 18, color: AppColor.kPrimaryColor),
                      hintStyle: TextStyle(fontSize: 14, color: AppColor.kTextColor3),

                      hoverColor: AppColor.kPrimaryColor,
                      floatingLabelBehavior: FloatingLabelBehavior.always, // Display label above the box
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18), // Padding for the hint text

                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Radio(
                          autofocus: true,
                          value: "Door To Door",
                          groupValue: _ServeceStatus,
                          onChanged: (String? value) {
                            setState(() {
                              _ServeceStatus = value!;
                            });
                          },
                          activeColor: AppColor.kPrimaryColor, // Set the active color for the radio button
                        ),
                        Text(
                          "Door To Door",
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
                          value: "Branch",
                          groupValue: _ServeceStatus,
                          onChanged: (String? value) {
                            setState(() {
                              _ServeceStatus = value!;
                            });
                          },
                          activeColor: AppColor.kPrimaryColor, // Set the active color for the radio button
                        ),
                        Text("Branch",
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
                      controller: _userAdreesController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusColor: AppColor.kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.kPrimaryColor),
                        ),
                        filled: true,
                        fillColor: AppColor.kPlaceholder2,
                        hintText: "Please enter your Address",
                        labelText: 'Address',
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
                          text: "Request",
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

  Widget _buildPhotolView() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        PlantPhotoView(file: _selectedImageFile),
        _buildAnalyzingText(),
      ],
    );
  }



  Widget _buildAnalyzingText() {
    if (!_isAnalyzing) {
      return const SizedBox.shrink();
    }
    return const Text('Analyzing...', style: kAnalyzingTextStyle);
  }


  Widget _buildPickPhotoButton({
    required ImageSource source,
    required String title,

  }) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            // When the button is pressed
            return AppColor.kAccentColor.withOpacity(0.8);
          } else if (states.contains(MaterialState.hovered)) {
            // When the button is hovered
            return AppColor.kAccentColor.withOpacity(0.9);
          } else {
            // Default button color
            return AppColor.kAccentColor;
          }
        }),
        foregroundColor: MaterialStateProperty.all(
          AppColor.kThirdColor,
        ),
      ),
      onPressed: () => _onPickPhoto(source),
      child: Text('$title'),


    );
  }

  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }
  void _onPickPhoto(ImageSource source) async {
    final file = await picker.pickImage(source: source);

    if (file == null) {
      return;
    }

    final imageFile = File(file.path);
    setState(() {
      _selectedImageFile = imageFile;
    });

    // Convert the image file to bytes
    final bytes = await imageFile.readAsBytes();

    setState(() {
      _file = bytes;
    });

    _analyzeImage(imageFile);
  }


  void _analyzeImage(File image) {
    _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier.predict(imageInput);

    final result = resultCategory.score >= 0.8
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final plantLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    _setAnalyzing(false);

    setState(() {
      _resultStatus = result;
      _plantLabel = plantLabel;
      _accuracy = accuracy;
    });
  }


  Widget _buildResultView() {

    //var title = '';

    if (_resultStatus == _ResultStatus.notFound) {
      _WasteType = 'Fail to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      _WasteType = _plantLabel;
    } else {
      _WasteType = '';
    }

    //
    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }


    return Column(
      children: [
        Container(
          height: 40.h,
         width: 305,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.kPlaceholder2,
            border: Border.all(
              color: AppColor.kPrimaryColor,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            'Waste Type: $_WasteType',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: AppColor.kTitle.withOpacity(0.8),
            ),
          ),
        ),

        const SizedBox(height: 5),
        Text(accuracyLabel,
          style:
          Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: AppColor.kTitle.withOpacity(0.8),
          ),),
      ],
    );
  }
}
