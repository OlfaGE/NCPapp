import 'package:auth_screen/pages/upload_photo/controller.dart';
import 'package:auth_screen/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

enum ImageSourceType { gallery, camera }

class UploadPhotoWidget extends StatefulWidget {
  final ImageSource source;
  UploadPhotoWidget({required this.source});

  @override
  UploadPhotoWidgetState createState() => UploadPhotoWidgetState();
}

class UploadPhotoWidgetState extends State<UploadPhotoWidget> {
  final controller = UploadPhotoController();
  late FToast fToast;
  UploadPhotoWidgetState();

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
    controller.attach(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Scan Part Barcode",
                      fillColor: kPrimaryColor),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    controller.onImageTap();
                  },
                  child: Container(
                    width: 300,
                    height: 900,
                    decoration: BoxDecoration(color: kBackgroundColor),
                    child: controller.file != null
                        ? Image.file(
                            controller.file!,
                            width: 300.0,
                            height: 900.0,
                            fit: BoxFit.fitHeight,
                          )
                        : Container(
                            decoration: BoxDecoration(color: kBackgroundColor),
                            width: 300,
                            height: 900,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              ),
              Spacer(),
              FittedBox(
                  child: Container(
                margin: EdgeInsets.only(bottom: 60),
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: kPrimaryColor,
                ),
                child: controller.file == null
                    ? null
                    : Row(
                        children: <Widget>[
                          FloatingActionButton.extended(
                            onPressed: () {
                              controller.onSendImage();
                              // Add confirmation code to send to API/Email here
                            },
                            label: Text(
                              "Send Image",
                              style:
                                  Theme.of(context).textTheme.button?.copyWith(
                                        color: Colors.black,
                                      ),
                            ),
                            icon: Icon(
                              Icons.check_box,
                              color: Colors.black,
                            ),
                            backgroundColor: kPrimaryColor,
                          ),
                        ],
                      ),
              ))
            ],
          ),
          _loaderView()
        ].whereType<Widget>().toList(),
      ),
    );
  }

  Widget? _loaderView() {
    if (!controller.isLoaderShowing) {
      return null;
    }
    return Positioned.fill(
      child: Container(
        color: Colors.white.withOpacity(0.5),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void applyState() {
    setState(() {});
  }

  void showErrorToast(String msg) {
    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline),
          SizedBox(
            width: 12.0,
          ),
          Text(msg),
        ],
      ),
    );

    fToast.showToast(child: child);
  }
}

PartInfo() {
  var list;
  list.add(new TextField(
    decoration: InputDecoration(hintText: 'Hint ${list.length + 1}'),
  ));
}
