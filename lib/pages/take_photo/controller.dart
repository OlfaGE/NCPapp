import 'package:auth_screen/pages/take_photo/view.dart';
import 'package:auth_screen/pages/upload_photo/view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoController {
  late TakePhotoWidgetState view;

  void attach(TakePhotoWidgetState _takePhotoWidgetState) {
    this.view = _takePhotoWidgetState;
  }

  Future<void> handleURLButtonPress(ImageSource source) async {
    Navigator.of(view.context).push(
      MaterialPageRoute(
        builder: (context) => UploadPhotoWidget(source: source),
      ),
    );
  }
}
