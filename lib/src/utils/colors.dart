import 'package:flutter/material.dart';

class Colors {
  static const persianBlue = Color(0xFF1825AD);
  static const athensGray = Color(0xFFF0F2F5);
  static const apple = Color(0xFF2DBA3F);
  static const mountainMeadow = Color(0xFF1EAA5D);
  static const denim = Color(0xFF154FC2);
  static const plantation = Color(0xFF2B5A50);
  static const towerGray = Color(0xFFA7BDBE);
  static const brightGray = Color(0xFF333A47);
  static const white = Color(0xFFFDFDFD);
}

class ColorMaps {
  static const Map<int, Color> greenMap = {
    50: Color.fromRGBO(0, 211, 165, .1),
    100: Color.fromRGBO(0, 211, 165, .2),
    200: Color.fromRGBO(0, 211, 165, .3),
    300: Color.fromRGBO(0, 211, 165, .4),
    400: Color.fromRGBO(0, 211, 165, .5),
    500: Color.fromRGBO(0, 211, 165, .6),
    600: Color.fromRGBO(0, 211, 165, .7),
    700: Color.fromRGBO(0, 211, 165, .8),
    800: Color.fromRGBO(0, 211, 165, .9),
    900: Color.fromRGBO(0, 211, 165, 1),
  };
  
  static const Map<int, Color> purpleMap = {
    50: Color.fromRGBO(62, 46, 146, .1),
    100: Color.fromRGBO(62, 46, 146, .2),
    200: Color.fromRGBO(62, 46, 146, .3),
    300: Color.fromRGBO(62, 46, 146, .4),
    400: Color.fromRGBO(62, 46, 146, .5),
    500: Color.fromRGBO(62, 46, 146, .6),
    600: Color.fromRGBO(62, 46, 146, .7),
    700: Color.fromRGBO(62, 46, 146, .8),
    800: Color.fromRGBO(62, 46, 146, .9),
    900: Color.fromRGBO(62, 46, 146, 1),
  };
}

class Swatchs {
  static const MaterialColor greenSwatch = MaterialColor(0xFF00D3A5, ColorMaps.greenMap);
  static const MaterialColor blueSwatch = MaterialColor(0xFF3E2E92, ColorMaps.purpleMap);
}
