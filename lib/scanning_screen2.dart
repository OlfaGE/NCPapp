import 'dart:io';

import 'package:auth_screen/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


enum ImageSourceType { gallery, camera }

class ScanningScreen2 extends StatelessWidget {

   void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
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
                  _handleURLButtonPress(context, ImageSourceType.gallery);
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
                  _handleURLButtonPress(context, ImageSourceType.camera);
                },
              ),
            ],
          ),
        ));
  }


}



class ImageFromGalleryEx extends StatefulWidget {
  final type;
  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var type;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
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
                        labelText:"Scan Part Barcode",
                        fillColor: kPrimaryColor
                      ),
                    ),
          ),

          Expanded(
              
                child: GestureDetector(
                  onTap: () async {
                    var source = type == ImageSourceType.camera
                        ? ImageSource.camera
                        : ImageSource.gallery;
                    XFile image = await imagePicker.pickImage(
                        source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
                    setState(() {
                      _image = File(image.path);
                    });
                  },
                  child: Container(
                    
                    width: 300,
                    height: 900,
                    decoration: BoxDecoration(
                        color: kBackgroundColor),
                    child: _image != null
                        ? Image.file(
                              _image,
                              width: 300.0,
                              height: 900.0,
                              fit: BoxFit.fitHeight,
                            )
                        : Container(
                            decoration: BoxDecoration(
                                color:kBackgroundColor),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kPrimaryColor,
                      ),
                      child: Row(
                        children: <Widget>[
                            FloatingActionButton.extended(
                                onPressed: () {
                                  // Add confirmation code to send to API/Email here
                              },
                              label: Text(
                                  "Send Image",
                                  style: Theme.of(context).textTheme.button.copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                                icon: Icon(Icons.check_box,
                            color: Colors.black, ),
                              backgroundColor:kPrimaryColor,
                            ),

                        ],
                      ),
              )
            
            
          )
          

          

        ],
      ),
    );
  }

  
}


PartInfo() {
  var list;
  list.add(new TextField(decoration: InputDecoration(hintText: 'Hint ${list.length+1}'),));

}