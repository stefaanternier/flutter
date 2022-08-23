// this is the old ApiGamesParticipateActionWithCursor in actions/games.dart

import 'package:youplay/models/game.dart';

import 'actions.dart';

class LoadParticipateGamesListRequestAction {
  String? cursor;

  LoadParticipateGamesListRequestAction({this.cursor});

  @override
  bool operator ==(dynamic other) {
    LoadParticipateGamesListRequestAction o = other as LoadParticipateGamesListRequestAction;
    return cursor == o.cursor;
  }

  @override
  int get hashCode => cursor.hashCode;

}

class LoadParticipateGamesListResponseAction extends GenericWebResponseAction {
//  String resultAsString;
//  dynamic resultAsJson;

  LoadParticipateGamesListResponseAction({resultAsString}): super(resultAsString:resultAsString);

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
  Game game;
  int gameId;

  LoadParticipateGameResponseAction({required this.game, required  this.gameId}); //: super(resultAsString:resultAsString);

}

class SetGameQuery {
  String? query;

  SetGameQuery({this.query});
}
