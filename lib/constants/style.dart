import 'package:flutter/material.dart';

import 'MyColors.dart';

class Style {
  static ThemeData theme() {
    return ThemeData(
        backgroundColor: MyColors.backgroudColor,
        primarySwatch: MyColors.primaryColorSwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //fontFamily: "Nunito",
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }));
  }
}
