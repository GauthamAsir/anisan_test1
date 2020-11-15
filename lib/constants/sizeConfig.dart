import 'package:flutter/material.dart';

class Sizes {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;
  static double padding;
  static double appBarHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    // On iPhone 11 the default = 10 almost
    // So if the screen size increases or decreases then our defaultSize also vary
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
    appBarHeight = AppBar().preferredSize.height;

    padding = defaultSize * 3;
  }
}
