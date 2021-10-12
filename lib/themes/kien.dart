import 'package:flutter/material.dart';

import 'customtransition.dart';

ThemeData kienTheme = ThemeData(

  primaryColor: const Color(0xFFD3107F),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFFD3107F),
    textTheme: ButtonTextTheme.primary,
  ),

  primarySwatch: const MaterialColor(
    0xFFD3107F, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffFAE2F0 ),//10%
      100: const Color(0xffF2B7D9),//20%
      200: const Color(0xffE988BF),//30%
      300: const Color(0xffE058A5),//40%
      400: const Color(0xffDA3492),//50%
      500: const Color(0xffD3107F),//60%
      600: const Color(0xffCE0E77),//70%
      700: const Color(0xffC80C6C),//80%
      800: const Color(0xffC20962),//90%
      900: const Color(0xffB7054F),//100%
    },
  ),
    accentColor: const Color(0xFFA9006B),
  // textTheme: new TextTheme(
  //   body1: new TextStyle(color: const Color(0xFF3EA3DC),),
  // ),
  //   pageTransitionsTheme: PageTransitionsTheme(
  //     builders: {
  //       // Set your transitions here:
  //       TargetPlatform.android: ZoomSlideUpTransitionsBuilder(),
  //       TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
  //       TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
  //     },
  //   ),
  brightness: Brightness.light,

);
