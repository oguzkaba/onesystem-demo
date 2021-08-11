import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xfff1f1f1),
  );

  final darkTheme = ThemeData.dark().copyWith(brightness: Brightness.dark);
}
