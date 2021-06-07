import 'package:flutter/material.dart';

List<ThemeData> arlearnThemes = [
  ThemeData(
    // Define the default Brightness and Colors
//    brightness: Brightness.dark,
    primaryColor: const Color(0xFF3EA3DC),
    primarySwatch: Colors.yellow,
    accentColor: const Color(0xFFA9006B),

    // Define the default Font Family
//    fontFamily: 'Montserrat',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
//    textTheme: TextTheme(
//      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
//    ),
  ),
  new ThemeData(
      primarySwatch: Colors.blue,
      accentColor: Colors.pink,
      backgroundColor: Colors.grey),
  new ThemeData(
      primarySwatch: Colors.yellow,
      accentColor: Colors.black,
      backgroundColor: Colors.grey),

];