import 'package:flutter/material.dart';

ThemeData rlTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color.fromRGBO(23, 26, 151, 1),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color.fromRGBO(23, 26, 151, 1),
    textTheme: ButtonTextTheme.primary,
  ),

  textTheme: new TextTheme(
    body1: new TextStyle(color: const Color.fromRGBO(23, 26, 151, 1)),
  ),
  primarySwatch: Colors.blue,
  accentColor: const Color(0xFFfbb615),
);

