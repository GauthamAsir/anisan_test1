import 'dart:async';

import 'package:anisan/constants/MyColors.dart';
import 'package:anisan/constants/sizeConfig.dart';
import 'package:anisan/state/auth/auth.dart';
import 'package:anisan/views/screens/home/home.dart';
import 'package:anisan/views/screens/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = MyColors.backgroudColor;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3;

  @override
  void initState() {
    super.initState();
    setup();
  }

  bool isNewUser = false;
  final pages = [
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      bubbleBackgroundColor: Colors.indigo,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Welcome to Anisan'),
          Text(
            'INTRO 1',
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
        ],
      ),
      mainImage: Icon(
        Icons.access_alarms,
        size: 60,
      ),
      textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      bubbleBackgroundColor: Colors.indigo,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text(
            'INTRO 2.1',
          ),
          Text(
            'INTRO 2.2',
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
        ],
      ),
      mainImage: Icon(
        Icons.ac_unit,
        size: 60,
      ),
      textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      bubbleBackgroundColor: Colors.indigo,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('INTRO 3.1'),
          Text(
            'INTRO 3.2',
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
        ],
      ),
      mainImage: Icon(
        Icons.person,
        size: 60,
      ),
      textStyle: TextStyle(color: Colors.black),
    ),
  ];

  setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getBool('isNewUser') == null) {
        isNewUser = true;
        return;
      }

      isNewUser = prefs.getBool('isNewUser');
    });

    var _duration = Duration(seconds: splashDelay);

    if (isNewUser != null && !isNewUser) return Timer(_duration, authenticate);
  }

  void authenticate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              /// Handle Auth here
              if (Auth.auth.currentUser != null)
                return Home();
              else
                return Login();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);

    return Scaffold(
      body: SafeArea(
          child: isNewUser
              ? Stack(
                  children: [
                    IntroViewsFlutter(
                      pages,
                      onTapDoneButton: () => navigateToHome(),
                      showSkipButton: true,
                      doneText: Text(
                        "Get Started",
                      ),
                      onTapSkipButton: () => navigateToHome(),
                      pageButtonsColor: MyColors.primaryColor,
                      pageButtonTextStyles: new TextStyle(
                        // color: Colors.indigo,
                        fontSize: 16.0,
                        fontFamily: "Regular",
                      ),
                    ),
                    Positioned(
                        top: 20.0,
                        left: Sizes.screenWidth / 2 - 50,
                        child: Text(
                          'LOGO',
                          textScaleFactor: 2,
                        ))
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: 'logo',
                        child: Wrap(
                          direction: Axis.vertical,
                          children: <Widget>[
                            Text(
                              'Splash Screen',
                              textScaleFactor: 2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }

  navigateToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNewUser', false);
    return Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => Home()));
  }
}
