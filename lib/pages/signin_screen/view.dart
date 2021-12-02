import 'package:auth_screen/pages/take_photo/view.dart';
import 'package:auth_screen/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/logo.PNG"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.alternate_email,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Email Address",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.lock,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Password",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(TakePhotoWidget.routeName);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: kPrimaryColor,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Sign In",
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
