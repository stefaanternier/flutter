import 'dart:convert';

import 'package:youplay/actions/actions.dart';
import 'package:youplay/actions/errors.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/api/games.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';

//final gameEpic = new TypedEpic<AppState, ApiGameAction>(_addGame);
//
//Stream<dynamic> _addGame(Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions.where((action) => action is ApiGameAction)
////      .distinct((action1, action2) => action1.gameId == action2.gameId)
//      .asyncMap((action) {
////        print("in add individual game ${action.gameId}");
//    return GamesApi.game(action.gameId, store.state.authentication.idToken)
//        .then((results) {
////      print("download game ${action.gameId} -  ${results}");
//      Map<String, dynamic> gameMap = jsonDecode(results);
//      if (gameMap.containsKey("error")) {
////              print("error in game fetching ${action.gameId}");
//        print("error code is ${gameMap["error"]["code"]}");
////        if (gameMap["error"]["code"] == 401) {
////          return new ApiRunGameAction(action.gameId);
////        }
//        return new ApiResultError(error: gameMap["error"]["code"]);
//      }
//
//      return new ApiResultGameAction(results);
//    }).catchError((error) => new ApiResultError(error: error));
//  });
//}


//
//final runGameEpic = new TypedEpic<AppState, ApiRunGameAction>(_addRunGame);
//
//Stream<dynamic> _addRunGame(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions
//      .where((action) => action is ApiRunGameAction)
//      .distinct((action1, action2) => action1.gameId == action2.gameId)
//      .asyncMap((action) =>
//          RunsApi.gameFromRun(action.gameId, store.state.authentication.idToken)
//              .then((results) {
//            Map<String, dynamic> gameMap = jsonDecode(results);
//            if (gameMap.containsKey("error")) {
//              return new ApiResultError(error: gameMap["error"]["code"]);
//            }
//
//            return new ApiResultGameAction(results);
//          }).catchError((error) => new ApiResultError(error: error)));
//}

//final gameParticipateEpic =
//    new TypedEpic<AppState, ApiGamesParticipateAction>(_gameParticipateStream);

bool _participateSuccesful = false;

//Stream<dynamic> _gameParticipateStream(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  print("in _gameParticipateStream ${store.state.authentication.idToken}");
//  return actions
//      .where((action) => action is ApiGamesParticipateAction)
////      .distinct((act1, act2) => _participateSuccesful)
//      .asyncMap((action) => store.state.authentication.idToken != null
//          ? GamesApi.participateWithCursor(
//                  store.state.authentication.idToken, '-')
//              .then((results) {
//              dynamic jsonResults = jsonDecode(results);
////              print("in my games ${jsonResults}");
//              if (jsonResults['gameIds'] != null) {
//                List<int> gameids = (jsonResults['gameIds'] as List<dynamic>)
//                    .map((id) => id as int)
//                    .toList(growable: false);
//                dynamic resultAction = checkError(
//                    jsonResults,
//                    new ApiResultGamesParticipateAction2(
//                        games: gameids,
//                        cursor: jsonResults['resumptionToken']));
//                _participateSuccesful = true;
//                return resultAction;
//              } else {
//                dynamic resultAction =
//                    checkError(jsonResults, new SetPage(PageType.featured)
//
////                    new ApiResultGamesParticipateAction2(
////                        games: [],
////                        cursor: jsonResults['resumptionToken'])
//                        );
//                _participateSuccesful = true;
//                return resultAction;
//              }
//            }).catchError((error) => new ApiResultError(error: error))
//          : null);
//}

//final gameParticipateWithCursorEpic =
//    new TypedEpic<AppState, ApiGamesParticipateActionWithCursor>(
//        _gameParticipateWithCursorEpic);
//
//Stream<dynamic> _gameParticipateWithCursorEpic(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions
//      .where((action) => action is ApiGamesParticipateActionWithCursor)
//      .asyncMap((action) => GamesApi.participateWithCursor(
//                  store.state.authentication.idToken, action.cursor)
//              .then((results) {
//            dynamic jsonResults = jsonDecode(results);
//            return checkError(
//                jsonResults,
//                new ApiResultGamesParticipateAction(
//                    games: jsonResults['gameIds'],
//                    cursor: jsonResults['resumptionToken']));
//          }).catchError((error) => new ApiResultError(error: error)));
//}

final gameParticipateResultsEpic =
    new TypedEpic<AppState, ApiResultGamesParticipateAction2>(
        _gameParticipateResultStream);

Stream<dynamic> _gameParticipateResultStream(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is ApiResultGamesParticipateAction2)
      .asyncExpand((action) {
    return _loadGamesStream(action);
  });
}

Stream<dynamic> _loadGamesStream(
    ApiResultGamesParticipateAction2 participateAction) async* {
  print("participate games ${participateAction.games}");
  for (int i = 0; i < participateAction.games.length; i++) {
//    print("trigger action for ${participateAction.games[i]}");
//    yield new ApiLoadRunAction(int.parse(users[i]['runId']));
//    yield new ApiGameAction(participateAction.games[i]);
    yield new  LoadGameRequestAction(participateAction.games[i]);

  }
  if (participateAction.cursor != null) {
    yield new ApiGamesParticipateActionWithCursor(
        cursor: participateAction.cursor);
  }
}

final dynamic checkError = (dynamic message, dynamic action) {
  if (message["error"] != null) {
    if (message["error"]["code"] == 401) {
//      print("inc check error 401");
      return new InvalidCredentials();
    }
  }
  return action;
};
