import 'package:auth_screen/pages/take_photo/view.dart';
import 'package:flutter/material.dart';

class UploadSuccessScreen extends StatefulWidget {
  static const String routeName = "/upload-success";
  const UploadSuccessScreen({Key? key}) : super(key: key);

  @override
  _UploadSuccessScreenState createState() => _UploadSuccessScreenState();
}

class _UploadSuccessScreenState extends State<UploadSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Successfully uploaded"),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(TakePhotoWidget.routeName));
              },
              child: Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
