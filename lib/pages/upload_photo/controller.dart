import 'dart:io';

import 'package:auth_screen/pages/upload_photo/view.dart';
import 'package:auth_screen/pages/upload_success/view.dart';
import 'package:auth_screen/services/box_api.dart';
import 'package:auth_screen/services/photo_picker_service.dart';
import 'package:auth_screen/utils/screenshotable/screenshotable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoController {
  late UploadPhotoWidgetState view;
  final filePickerService = UploadFileOrPickImageService();
  final boxApi = BoxApi();
  final ScreenshotController screenshotController = ScreenshotController();

  bool isLoaderShowing = false;
  File? file;

  void attach(UploadPhotoWidgetState uploadPhotoWidgetState) {
    this.view = uploadPhotoWidgetState;
  }

  Future<void> onImageTap() async {
    final file =
        await filePickerService.getImage(view.widget.source, CameraDevice.rear);
    if (file == null) return;
    this.file = file;
    this.view.applyState();
  }

  void showLoader() {
    isLoaderShowing = true;
    view.applyState();
  }

  void closeLoader() {
    isLoaderShowing = false;
    view.applyState();
  }

  _uploadFile(File file) async {
    await boxApi.uploadFile(file);
  }

  Future<void> onSendImageTapped() async {
    final file = this.file;
    if (file == null) return;
    showLoader();
    try {
      await _uploadFile(file);
      // await _uploadScreenshot();
      closeLoader();
      Navigator.of(view.context).pushNamed(UploadSuccessScreen.routeName);
    } catch (e) {
      view.showErrorToast(e.toString());
      closeLoader();
      rethrow;
    }
  }

  _uploadScreenshot() async {
    final image = await screenshotController.takeFlutterScreenShoot();
    if (image == null) return;
    await boxApi.uploadImage(image);
  }
}
