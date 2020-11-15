import 'package:anisan/constants/MyColors.dart';
import 'package:anisan/views/screens/home/home.dart';
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
          child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: FlatButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, new MaterialPageRoute(builder: (context) => Home()));
          },
          child: Center(
            child: Text(
              "Skip for Now",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
      )),
    );
  }
}
