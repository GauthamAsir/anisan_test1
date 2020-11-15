import 'package:anisan/constants/MyColors.dart';
import 'package:anisan/constants/sizeConfig.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  Button({@required this.buttonText, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.screenHeight * 0.06,
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
      child: FlatButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            buttonText == null ? '' : buttonText,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: MyColors.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
