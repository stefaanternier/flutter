import 'dart:collection';
import 'dart:ui';
import 'dart:ui';

import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'general_item/dependency.dart';

class Game {
  int gameId;
  int? sharing;
  double? lat;
  double? lng;
  String language;
  String title;
  String iconAbbreviation;
  String description;
  String? messageListScreen;
  int theme;
  int lastModificationDate;
  bool privateMode;
  GameConfig? config;
  Dependency? endsOn;

  Game.fromJson(Map json)
      : gameId = int.parse("${json['gameId']}"),
        lastModificationDate = json['lastModificationDate'] != null
            ? int.parse("${json['lastModificationDate']}")
            : 0,
        sharing = json['sharing'],
        privateMode = json['privateMode'] ?? false,
        lat = json['lat'],
        lng = json['lng'],
        endsOn =
            json['endsOn'] != null ? Dependency.fromJson(json['endsOn']) : null,
        language = json['language'],
        theme = int.parse("${json['theme']}"),
        title = json['title'] ?? '',
        description = json['description'] ?? '',
        messageListScreen = json['messageListScreen'],
        iconAbbreviation = json['iconAbbreviation'] ?? '',
        config = GameConfig.fromJson(json['config']);

  Game(
      {required this.gameId,
      this.lastModificationDate = 0,
      required this.sharing,
      this.lat = -1,
      this.lng = -1,
      this.language = 'en',
      this.theme = 0,
      this.endsOn,
      this.privateMode = false,
      this.title = "no title",
      this.messageListScreen,
      this.description = "",
      this.iconAbbreviation = ''});

  dynamic toJson() {
    return {
      'gameId': this.gameId,
      'lastModificationDate': this.lastModificationDate,
      'sharing': this.sharing,
      'lat': this.lat,
      'lng': this.lng,
      'language': this.language,
      'title': this.title,
      'theme': this.theme,
      'iconAbbreviation': this.iconAbbreviation,
      'privateMode': this.privateMode,
    };
  }

  int endsAt(HashMap<String, ARLearnAction> actions) {
    if (endsOn == null || actions == null) return -1;
    return endsOn!.evaluate(actions);
  }

  nextView(MessageView currentView) {
    if (currentView == MessageView.mapView) {
      return MessageView.listView;
    }
    return MessageView.mapView;
  }
}

class GameConfig {
  bool mapAvailable;
  bool enableMyLocation;
  bool enableExchangeResponses;
  int minZoomLevel;
  int maxZoomLevel;

  // Color primaryColor;
  Color secondaryColor;

  GameConfig(
      {required this.mapAvailable,
      required this.enableMyLocation,
      required this.enableExchangeResponses,
      required this.minZoomLevel,
      required this.maxZoomLevel,
      // this.primaryColor,
      required this.secondaryColor});

  GameConfig.fromJson(Map json)
      : mapAvailable = json['mapAvailable'],
        enableMyLocation = json['enableMyLocation'],
        enableExchangeResponses = json['enableExchangeResponses'],
        minZoomLevel = json['minZoomLevel'],
        maxZoomLevel = json['maxZoomLevel'],
        // primaryColor = json['primaryColor'] != null
        //     ? colorFromHex(json['primaryColor'])
        //     : AppConfig().themeData.primaryColor,
        secondaryColor = json['secondaryColor'] != null
            ? colorFromHex(json['secondaryColor'])
            : AppConfig().themeData!.accentColor;
}

Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

class GameFile {
  String path;
  int id;

  GameFile({required this.path, required this.id});

  GameFile.fromJson(Map json)
      : id = int.parse("${json['id']}"),
        path = json['path'];
}

//{
//"type": "org.celstec.arlearn2.beans.game.Game",
//"gameId": 620064,
//"config": {
//"type": "org.celstec.arlearn2.beans.game.Config",
//"mapAvailable": false,
//"enableExchangeResponses": true,
//"enableMyLocation": false,
//"minZoomLevel": 1,
//"maxZoomLevel": 20,
//"manualItems": [],
//"locationUpdates": []
//},
//"language": "nl",
//"rank": 3,
//"theme": 1
//},
//
//Color colorFromHex(String hexString) {
//  final buffer = StringBuffer();
//  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//  buffer.write(hexString.replaceFirst('#', ''));
//  return Color(int.parse(buffer.toString(), radix: 16));
//}

//
//extension HexColor on Color {
//  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
//  static Color fromHex(String hexString) {
//    final buffer = StringBuffer();
//    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//    buffer.write(hexString.replaceFirst('#', ''));
//    return Color(int.parse(buffer.toString(), radix: 16));
//  }
//
//  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
//  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
//      '${alpha.toRadixString(16).padLeft(2, '0')}'
//      '${red.toRadixString(16).padLeft(2, '0')}'
//      '${green.toRadixString(16).padLeft(2, '0')}'
//      '${blue.toRadixString(16).padLeft(2, '0')}';
//}
