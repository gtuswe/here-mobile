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


  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    blockArea = blockSizeHorizontal * blockSizeVertical;
    isPortrait = _mediaQueryData.orientation == Orientation.portrait;
    isDarkTheme = _mediaQueryData.platformBrightness == Brightness.dark;
  }
}