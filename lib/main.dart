import 'package:auth_screen/pages/take_photo/view.dart';
import 'package:auth_screen/pages/upload_success/view.dart';
import 'package:auth_screen/pages/welcome_screen/view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NCP Application',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
      ),
      home: WelcomeScreen(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case TakePhotoWidget.routeName:
            return MaterialPageRoute(
              builder: (_) => TakePhotoWidget(),
              settings: settings,
            );
          case UploadSuccessScreen.routeName:
            return MaterialPageRoute(
              builder: (_) => UploadSuccessScreen(),
              settings: settings,
            );
        }
      },
    );
  }
}
