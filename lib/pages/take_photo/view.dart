import 'package:auth_screen/pages/take_photo/controller.dart';
import 'package:auth_screen/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoWidget extends StatefulWidget {
  static const String routeName = "/takePhoto";
  const TakePhotoWidget({Key? key}) : super(key: key);

  @override
  TakePhotoWidgetState createState() => TakePhotoWidgetState();
}

class TakePhotoWidgetState extends State<TakePhotoWidget> {
  final controller = TakePhotoController();
  @override
  void initState() {
    super.initState();
    controller.attach(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/scanning.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          MaterialButton(
            color: kPrimaryColor,
            child: Text(
              "Choose from Gallery",
              style: TextStyle(
                  color: kBackgroundColor, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              controller.handleURLButtonPress(ImageSource.gallery);
            },
          ),
          MaterialButton(
            color: kPrimaryColor,
            child: Text(
              "Capture Image",
              style: TextStyle(
                  color: kBackgroundColor, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              controller.handleURLButtonPress(ImageSource.camera);
            },
          ),
        ],
      ),
    ));
  }
}
