import 'dart:collection';
import 'dart:ui';

import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/run.dart';

import 'general_item/dependency.dart';

class Game {
  String get id => '$gameId';
  int gameId;
  int? sharing;
  int? rank;
  int? amountOfPlays;
  String? playDuration;
  String? ageSpan;
  String? devTeam;

  double? lat;
  double? lng;
  double boardHeight;
  double boardWidth;
  String language;
  String title;
  String iconAbbreviation;
  String description;
  String? organisationId;
  String? messageListScreen;
  String? startButton;
  String? gameOverHeading;
  String? gameOverButton;
  String? gameOverDescription;
  List<int> messageListTypes;

  int theme;
  int lastModificationDate;
  int chapters;
  bool privateMode;
  bool webEnabled;
  bool deleted;
  GameConfig? config;
  Dependency? endsOn;

  Game.fromJson(Map json)
      : gameId = int.parse("${json['gameId']}"),
        theme = int.parse("${json['theme']}"),
        lastModificationDate = json['lastModificationDate'] != null ? int.parse("${json['lastModificationDate']}") : 0,
        chapters = json['chapters'] != null ? int.parse("${json['chapters']}") : 0,
        rank = json['rank'] != null ? int.parse("${json['rank']}") : 1,
        amountOfPlays = json['amountOfPlays'] != null ? int.parse("${json['amountOfPlays']}") : 0,
        sharing = json['sharing'],
        ageSpan = json['ageSpan'] ?? '0 - 99',
        playDuration = json['playDuration'] ?? '0 - 60',
        devTeam = json['devTeam'],
        privateMode = json['privateMode'] ?? false,
        webEnabled = json['webEnabled'] ?? false,
        lat = json['lat'],
        lng = json['lng'],
        boardHeight = json['boardHeight'] != null ? (json['boardHeight'] as int).toDouble() : 1920,
        boardWidth = json['boardWidth'] != null ? (json['boardWidth'] as int).toDouble() : 1080,
        endsOn = json['endsOn'] != null ? Dependency.fromJson(json['endsOn']) : null,
        language = json['language'],
        title = json['title'] ?? '',
        description = json['description'] ?? '',
        organisationId = json['organisationId'],
        messageListScreen = json['messageListScreen'],
        startButton = json['startButton'],
        gameOverHeading = json['gameOverHeading'],
        gameOverButton = json['gameOverButton'],
        gameOverDescription = json['gameOverDescription'],
        messageListTypes = (json['messageListTypes'] ?? "")
            .split(',')
            .where((nAsString) => nAsString.trim() != "")
            .map<int>((nAsString) => int.parse('$nAsString'))
            .where((x) => !(UniversalPlatform.isWeb && x == 3)) //exclude maps for web
            .toList(),
        iconAbbreviation = json['iconAbbreviation'] ?? '',
        deleted = json['deleted'] ?? false,
        config = json['config'] != null ? GameConfig.fromJson(json['config']) : null;

  Game(
      {required this.gameId,
      this.lastModificationDate = 0,
      required this.sharing,
      this.rank,
      this.amountOfPlays,
      this.ageSpan,
      this.playDuration,
      this.devTeam,
      this.lat = -1,
      this.lng = -1,
      required this.boardHeight,
      required this.boardWidth,
      this.language = 'en',
      this.theme = 0,
      this.endsOn,
      this.privateMode = false,
      this.webEnabled = false,
      this.title = "no title",
      this.messageListScreen,
      this.startButton,
      this.gameOverHeading,
      this.gameOverButton,
      this.gameOverDescription,
      required this.messageListTypes,
      required this.chapters,
      this.description = "",
      this.organisationId,
      this.deleted = false,
      this.iconAbbreviation = ''});

  dynamic toJson() {
    dynamic j = {
      'gameId': this.gameId,
      'lastModificationDate': this.lastModificationDate,
      'chapters': this.chapters,
      'sharing': this.sharing,
      'rank': this.rank,
      'amountOfPlays': '${this.amountOfPlays}',
      'playDuration': this.playDuration,
      'devTeam': this.devTeam,
      'ageSpan': this.ageSpan,
      'privateMode': this.privateMode,
      'organisationId': this.organisationId,
      'webEnabled': this.webEnabled,
      'lat': this.lat,
      'lng': this.lng,
      'boardHeight': this.boardHeight.toInt(),
      'boardWidth': this.boardWidth.toInt(),
      'language': this.language,
      'theme': this.theme,
      'title': this.title,
      'messageListScreen': this.messageListScreen,
      'startButton': this.startButton,
      'gameOverHeading': this.gameOverHeading,
      'gameOverButton': this.gameOverButton,
      'gameOverDescription': this.gameOverDescription,
      'iconAbbreviation': this.iconAbbreviation,
      'messageListTypes': this.messageListTypes.length == 1
          ? '${this.messageListTypes[0]}'
          : this.messageListTypes.map((entry) => '$entry').join(','),
      'deleted': this.deleted,
    };
    return j;
  }

  int endsAt(HashMap<String, ARLearnAction> actions) {
    if (endsOn == null || actions == null) return -1;
    return endsOn!.evaluate(actions);
  }

  nextView(int currentView) {
    if (currentView == 0) {
      return firstView;
    }
    if (messageListTypes.length <= 1) {
      return currentView;
    }
    int index = (messageListTypes.indexOf(currentView) + 1) % messageListTypes.length;
    return messageListTypes[index];
  }

  int get firstView {
    if (messageListTypes.length == 0) {
      return 2;
    }
    return messageListTypes[0];
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
        secondaryColor =
            json['secondaryColor'] != null ? colorFromHex(json['secondaryColor']) : AppConfig().themeData!.accentColor;
}

Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

String colorToHex({required Color color, bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
    '${color.alpha.toRadixString(16).padLeft(2, '0')}'
    '${color.red.toRadixString(16).padLeft(2, '0')}'
    '${color.green.toRadixString(16).padLeft(2, '0')}'
    '${color.blue.toRadixString(16).padLeft(2, '0')}';

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

class GameList {
  List<Game> items;
  String? resumptionToken;

  GameList({required this.items, this.resumptionToken});

  GameList.fromJson(Map json)
      : items = json['games'] != null
            ? (json['games'] as List<dynamic>).map<Game>((map) => Game.fromJson(map)).toList(growable: false)
            : [],
        resumptionToken = json['resumptionToken'];
}
