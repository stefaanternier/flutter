// this is the old ApiGamesParticipateActionWithCursor in actions/games.dart
import 'dart:convert';

import 'package:youplay/models/game.dart';

import 'actions.dart';

class LoadParticipateGamesListRequestAction {
  String? cursor;

  LoadParticipateGamesListRequestAction({this.cursor});
}

class LoadParticipateGamesListResponseAction extends GenericWebResponseAction {
//  String resultAsString;
//  dynamic resultAsJson;

  LoadParticipateGamesListResponseAction({resultAsString}): super(resultAsString:resultAsString);

//  decode() {
//    this.resultAsJson = jsonDecode(this.resultAsString);
//  }

//  getResultsAsJson() {
//    if (resultAsJson == null) {
//      decode();
//    }
//    return resultAsJson;
//  }

  List<int> getResultIdentifiers() {
    dynamic json = getResultsAsJson();
    if (json["items"] == null) return [];
    return (json["items"] as List<dynamic>)
        .map((idAsString) => int.parse(idAsString))
        .toSet().toList();
  }

//  bool isError() {
//    if (resultAsJson == null) {
//      decode();
//    }
//    return resultAsJson["error"] != null;
//  }
}

class LoadParticipateGameRequestAction  {
  int gameId;

  LoadParticipateGameRequestAction(this.gameId);
}

class LoadParticipateGameResponseAction {
//  String resultAsString;
  Game game;
  int gameId;
//  dynamic resultAsJson;

  LoadParticipateGameResponseAction({required this.game, required  this.gameId}); //: super(resultAsString:resultAsString);

//  decode() {
//    this.resultAsJson = jsonDecode(this.resultAsString);
//  }
//
//  bool isError() {
//    if (resultAsJson == null) {
//      decode();
//    }
//    return resultAsJson["error"] != null;
//  }

//  getResultsAsJson() {
//    if (resultAsJson == null) {
//      decode();
//    }
//    return resultAsJson;
//  }

//  Game getGame() {
//    return Game.fromJson(getResultsAsJson());
//  }
}
