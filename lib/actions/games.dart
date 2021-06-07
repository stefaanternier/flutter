import 'package:youplay/models/game.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';



//class ApiGamesParticipateAction{
//
//}

class ApiGamesParticipateActionWithCursor{
  String cursor;

  ApiGamesParticipateActionWithCursor({this.cursor});


}

class ApiResultGamesParticipateAction {
  List<int> games;
  String cursor;

  ApiResultGamesParticipateAction({this.games, this.cursor});
}

class ApiResultGamesParticipateAction2 {
  List<int> games;
  String cursor;

  ApiResultGamesParticipateAction2({this.games, this.cursor});
}

//class ApiGameAction{
//  int gameId;
//  ApiGameAction(this.gameId);
//
//}

////todo check if this is necessary
//class ApiRunGameAction{
//  int gameId;
//  ApiRunGameAction(this.gameId);
//
//}

class ApiResultGameAction {
  dynamic game;

  ApiResultGameAction(this.game);
}
//
//class ApiGameGeneralItems{
//  int gameId;
//  ApiGameGeneralItems(this.gameId);
//
//}

//class ApiResultGameGeneralItems {
//  dynamic generalItems;
//  int gameId;
//
//  ApiResultGameGeneralItems(this.generalItems, this.gameId);
//}


class AddGameAction {
  Game game;
  AddGameAction(this.game );
}

class LoadMyGamesAction{}


//class MyGamesResultsAction {
//  dynamic games;
//
//  MyGamesResultsAction(this.games);
//}

class MyGamesErrorAction {
  dynamic error;

  MyGamesErrorAction(this.error);
}



class SetCurrentGeneralItemId {
  int itemId;

  SetCurrentGeneralItemId(this.itemId);
}


class GameQrAction {
  String qrCode;

  GameQrAction(this.qrCode);
}

class RunQrAction {
  final Store store;
  String qrCode;
  BuildContext context;
  RunQrAction(this.qrCode, this.context, this.store);

}

class AddMeToRun {
  int runId;

  AddMeToRun(this.runId);
}

//class SyncGameContent {
//  int gameId;
//
//  SyncGameContent(this.gameId);
//}
//
class SyncGameContentResult {
  int gameId;
  List gameFiles;
  SyncGameContentResult(this.gameId, this.gameFiles);
}

//
//class SyncGameFile {
//  int gameId;
//  int fileId;
//  String path;
//
//  SyncGameFile(this.gameId, this.fileId, this.path);
//}

