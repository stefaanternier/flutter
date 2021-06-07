import 'package:flutter/material.dart';

ThemeData youplayTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFE2001A),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFFE2001A),
    textTheme: ButtonTextTheme.primary,
  ),

  textTheme: new TextTheme(
    body1: new TextStyle(color: const Color(0xFFE2001A)),
  ),
  primarySwatch: Colors.red,
  accentColor: const Color(0xFFE2001A),
);
