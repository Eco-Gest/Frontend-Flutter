import 'package:flutter/material.dart';

abstract class EcogestTheme {
  static const int _primary = 0xff03DC71;

  static const MaterialColor primary = MaterialColor(_primary, <int, Color>{
    50: Color(0x0003DC71),
    100: Color(0x2203DC71),
    200: Color(0x3303DC71),
    300: Color(0x4403DC71),
    400: Color(0x6603DC71),
    500: Color(0x7703DC71),
    600: Color(0x9903DC71),
    700: Color(0xaa03DC71),
    800: Color(0xdd03DC71),
    900: Color(0xff03DC71)
  });
}