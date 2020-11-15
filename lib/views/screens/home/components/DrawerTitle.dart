import 'package:anisan/constants/MyColors.dart';
import 'package:flutter/material.dart';

class DrawerTitle extends StatelessWidget {
  final String title;

  const DrawerTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          color: MyColors.backgroudColor,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}
