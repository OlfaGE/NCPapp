import 'dart:io';

import 'package:auth_screen/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadFileOrPickImageService {
  Future<File?> getImage(ImageSource source, CameraDevice device) async {
    print("$logTrace $device");
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: source, preferredCameraDevice: device);
    if (pickedFile == null) {
      return null;
    }
    print("$logTrace ${pickedFile.path}");
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: pickedFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
//        CropAspectRatioPreset.ratio3x2,
//        CropAspectRatioPreset.original,
//        CropAspectRatioPreset.ratio4x3,
//        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
        resetAspectRatioEnabled: true,
        aspectRatioLockEnabled: true,
      ),
    );
    return croppedFile;
  }
}
