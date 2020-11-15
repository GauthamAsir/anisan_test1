import 'package:flutter/material.dart';

class MyColors {
  static MaterialColor get primaryColorSwatch {
    Map<int, Color> color = {
      50: Color.fromRGBO(47, 60, 126, .1),
      100: Color.fromRGBO(47, 60, 126, .2),
      200: Color.fromRGBO(47, 60, 126, .3),
      300: Color.fromRGBO(47, 60, 126, .4),
      400: Color.fromRGBO(47, 60, 126, .5),
      500: Color.fromRGBO(47, 60, 126, .6),
      600: Color.fromRGBO(47, 60, 126, .7),
      700: Color.fromRGBO(47, 60, 126, .8),
      800: Color.fromRGBO(47, 60, 126, .9),
      900: Color.fromRGBO(47, 60, 126, 1),
    };
    return MaterialColor(0xFF2F3C7E, color);
  }

  static const primaryColor = Color(0xFF2F3C7E);
  static const kPrimaryDark = Color(0xFF2F3C7E);


  static const Color backgroudColor = Color(0xFFF9F9F9);
}
