import 'package:anisan/views/screens/home/home.dart';
import 'package:anisan/widgets/button.dart';
import 'package:flutter/material.dart';

class RequestLocation extends StatefulWidget {
  @override
  _RequestLocationState createState() => _RequestLocationState();
}

class _RequestLocationState extends State<RequestLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Button(
              buttonText: 'Skip For Now',
              onPressed: () {
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => Home()));
              })),
    );
  }
}
