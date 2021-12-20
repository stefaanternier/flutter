import 'package:flutter/material.dart';

import 'game.dart';

class GameTheme {
  int themeId;
  Color primaryColor;

//  Color primaryColorC = Colors.lightGreen;
  bool global;
  String iconPath;
  String backgroundPath;
  String correctPath;
  String wrongPath;

  GameTheme(
      {required this.themeId,
        required this.primaryColor,
        required  this.global,
        required   this.iconPath,
        required  this.backgroundPath,
        required  this.correctPath,
        required  this.wrongPath});

  GameTheme.fromJson(Map json)
      : themeId = int.parse("${json['themeId']}"),
        primaryColor =
            json['primaryColor'] != null ? colorFromHex(json['primaryColor']) : Colors.green,
        global = json['global'] == 'true',
        iconPath = json['iconPath'] ?? 'themes/1/icon.png',
        backgroundPath = json['backgroundPath'] ?? 'themes/1/screenshot-bg.png',
        correctPath = json['correctPath'] ?? 'themes/1/screenshot-correct.png',
        wrongPath = json['wrongPath'] ?? 'themes/1/screenshot-wrong.png';
}
