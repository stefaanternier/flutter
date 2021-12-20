import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

enum AppEnvironment {
  YOUPLAY,
  UPPGAMES,
  PROD,
  KIENPROD,
  KIENDEV,
  DIDOPROD,
  ROUTELIMBURG
}

class AppConfig {
  // Singleton object
  static final AppConfig _singleton = new AppConfig._internal();

  factory AppConfig() {
    return _singleton;
  }

  AppConfig._internal();

  AppEnvironment? appEnvironment;
  String? appName;
  bool? showIntro;
  String? description;
  String? appBarIcon;
  String baseUrl = '';
  String? iosAppId;
  String? androidAppId;
  String? gcmSenderID;
  String? apiKey;
  String? projectID;
  String? storageBucket;
  ThemeData? themeData;
  CustomTheme? customTheme;

  // Map featuredGames;
  Map? loginConfig;
  FirebaseStorage? storage;
  FirebaseAnalytics? analytics;

  // Set app configuration with single function
  void setAppConfig(
      {AppEnvironment? appEnvironment,
      String? appName,
        bool? showIntro,
      String? description,
      String? appBarIcon,
      String? baseUrl,
      String? iosAppId,
      String? androidAppId,
      String? gcmSenderID,
      String? apiKey,
      String? projectID,
      String? storageBucket,
      ThemeData? themeData,
      CustomTheme? customTheme,
      Map? featuredGames,
      Map? loginConfig,
      FirebaseAnalytics? analytics}) {
    this.appEnvironment = appEnvironment;
    this.appName = appName;
    this.showIntro = showIntro ?? false;
    this.description = description;
    this.baseUrl = baseUrl ?? '';
    this.appBarIcon = appBarIcon;
    this.iosAppId = iosAppId;
    this.androidAppId = androidAppId;
    this.gcmSenderID = gcmSenderID;
    this.apiKey = apiKey;
    this.projectID = projectID;
    this.storageBucket = storageBucket;
    this.themeData = themeData;
    this.customTheme = customTheme;
    // this.featuredGames = featuredGames;
    this.loginConfig = loginConfig!;
    this.analytics = analytics!;
  }

  static void setStorage(FirebaseStorage storage) {
    _singleton.storage = storage;
  }

  static bool isTablet() {
    if (WidgetsBinding.instance == null) {
      return false;
    }
    if (WidgetsBinding.instance!.window == null) {
      return false;
    }
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide > 600;
  }

  String getStorageUrl() {
    return "https://storage.googleapis.com/$projectID.appspot.com";
  }

  String get storageUrl {
    return "https://storage.googleapis.com/$projectID.appspot.com";
  }
}

const Color white08 = Color(0xCCFFFFFF);

class CustomTheme {
  TextStyle nextButtonStyle;
  TextStyle cardTextStyle;
  TextStyle cardTitleStyle;
  TextStyle cardTitleStyleTablet;
  TextStyle cardContentStyle;

  TextStyle listEntryTitle;
  TextStyle listEntrySubTitle;
  TextStyle listEntryEndOfLine;

  TextStyle mcOptionTextStyle;

  TextStyle runListEntryTitle;

  CustomTheme({
    this.nextButtonStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.w900,
    ),
    this.cardTextStyle = const TextStyle(
        color: const Color(0xdd000000),
        fontSize: 20,
        fontWeight: FontWeight.w500),
    this.cardTitleStyleTablet = const TextStyle(
        color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
    this.cardTitleStyle = const TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    this.cardContentStyle = const TextStyle(
        color: const Color(0xff485460),
        fontSize: 16,
        fontWeight: FontWeight.normal),
    this.listEntryTitle = const TextStyle(
        color: const Color(0xff1E272E),
        fontSize: 14,
        fontWeight: FontWeight.bold),
    this.listEntrySubTitle = const TextStyle(
        color: const Color(0xff485460),
        fontSize: 14,
        fontWeight: FontWeight.normal),
    this.listEntryEndOfLine = const TextStyle(
        color: const Color(0xffA0ABB5),
        fontSize: 14,
        fontWeight: FontWeight.w300),
    this.runListEntryTitle = const TextStyle(
        color: const Color(0xff272727),
        fontSize: 16,
        fontWeight: FontWeight.bold),
    this.mcOptionTextStyle = const TextStyle(
      color: const Color(0xdd000000),
      fontSize: 16,
    ),
  });
}
