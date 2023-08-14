import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeros/Testing/ui/screens/tab/charity/step_two_screen.dart';
import 'package:zeros/machineLearning/classifier/classifier.dart';
import 'package:zeros/machineLearning/styles.dart';
import 'package:zeros/machineLearning/widget/plant_photo_view.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import '../../../widgets/charity/charity_scaffold.dart';
import '../../../widgets/charity/steps.dart';

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'model_unquant.tflite';

class StepOneScreen extends StatefulWidget {

   StepOneScreen();
  static var routeName = '/step_one_screen';

  //const StepOneScreen();

  @override
  State<StepOneScreen> createState() => _StepOneScreenState();
}

enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class _StepOneScreenState extends State<StepOneScreen> {
  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;
  late String imagePath;


  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _plantLabel = ''; // Name of Error Message
  double _accuracy = 0.0;

  String title = ''; // Name of Error Message

  late Classifier _classifier;

  @override
  void initState() {
    super.initState();
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


  @override
  Widget build(BuildContext context) {
    return CharityScaffold(
      children: <Widget>[
        Text(
          'Start a Recycling',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF0D732D),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          'Complete The Following Steps to proceed to this Recycling program',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 12.h,
        ),
        Steps(0, 4),
        SizedBox(
          height: 12.h,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPhotolView(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildResultView(),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),

                    Column(
                      children: [
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
                          height: 12.h,
                        ),

                        Column(
                          children: [
                            _buildPickPhotoButton(
                              title: 'Pick from gallery',
                              source: ImageSource.gallery,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),

                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],


      button:
      ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          foregroundColor: MaterialStateProperty.all(AppColor.kPlaceholder2),
          backgroundColor: MaterialStateProperty.all(AppColor.kAccentColor),
          elevation: MaterialStateProperty.all(0),
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 48.h)),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 24.w)),
        ),
        onPressed: () {
          if (_selectedImageFile == null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Image not selected'),
                content: Text('Please select an image.'),
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      foregroundColor: MaterialStateProperty.all(AppColor.kPlaceholder2),
                      backgroundColor: MaterialStateProperty.all(AppColor.kAccentColor),
                      elevation: MaterialStateProperty.all(0),
                      minimumSize: MaterialStateProperty.all(Size(double.infinity, 48.h)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 24.w)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StepTwoScreen(image: imagePath,type:title,),
                      ),
                      );
                      Navigator.of(context).pushNamed(RouteGenerator.stepOne);
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
            );
            return;
          }

          Navigator.of(context).pushNamed(RouteGenerator.stepTwo);
        },
        child: Text('Next'),
      ),



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
      style:
      ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8.r,
            ),
          ),
        ),
        foregroundColor: MaterialStateProperty.all(
          AppColor.kPlaceholder2,
        ),
        backgroundColor: MaterialStateProperty.all(
          AppColor.kAccentColor,
        ),
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(
          Size(
            double.infinity,
            48.h,
          ),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
        ),
      ),      onPressed: () => _onPickPhoto(source),
      child: Text('$title'),


    );
  }

  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }
  void _onPickPhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
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

    var title = '';

    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Fail to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      title = _plantLabel;
    } else {
      title = '';
    }

    //
    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }


    return Column(
      children: [
        Text(title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColor.kPrimaryColor,
          ),),
        const SizedBox(height: 5),
        Text(accuracyLabel,
          style:
          Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: AppColor.kPrimaryColor,
          ),),
      ],
    );
  }
}
