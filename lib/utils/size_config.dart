import 'package:flutter/material.dart';

/// Helper class for ui size configuration
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double blockArea;
  static late bool isPortrait;
  static late bool isDarkTheme;


  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    isPortrait = _mediaQueryData.orientation == Orientation.portrait;
    isDarkTheme = _mediaQueryData.platformBrightness == Brightness.dark;

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    blockSizeHorizontal = isPortrait ? screenWidth / 100 : screenHeight / 100;
    blockSizeVertical = isPortrait ? screenHeight / 100 : screenWidth / 100;
    blockArea = blockSizeHorizontal * blockSizeVertical;
  }
}