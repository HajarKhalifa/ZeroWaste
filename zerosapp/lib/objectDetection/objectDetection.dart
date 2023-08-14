import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../objectDetection/realtime/live_camera.dart';
import '../objectDetection/static image/static.dart';

class ObjectDetection extends StatefulWidget {
  static var routeName='/ObjectDetection';

  @override
  _ObjectDetectionState createState() => _ObjectDetectionState();
}

class _ObjectDetectionState extends State<ObjectDetection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Object Detector App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: aboutDialog,
          ),
        ],
      ),
      body: Container(
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 170,
                child: ElevatedButton(
                  child: Text("Detect in Image"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => StaticImage(),
                    ),
                    );
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 160,
                child: ElevatedButton(
                  child: Text("Real Time Detection"),
                  onPressed:() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LiveFeed(cameras),
                    ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  aboutDialog(){
    showAboutDialog(
      context: context,
      applicationName: "Object Detector App",
      applicationLegalese: "By Rupak Karki",
      applicationVersion: "1.0",
      children: <Widget>[
        Text("www.rupakkarki.com.np"),
      ],
    );
  }

}