import 'dart:async';
import 'dart:convert';
import 'package:youplay/actions/games.dart';
import 'package:youplay/api/runs.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';

import '../localizations.dart';

// final qrActions = new TypedEpic<AppState, RunQrAction>(_runQRAction);
final addMeToRun = new TypedEpic<AppState, AddMeToRun>(_addMeToRun);

// Stream<dynamic> _runQRAction(Stream<dynamic> actions, EpicStore<AppState> store) {
//   return actions
//       .where((action) => action is RunQrAction)
//       .asyncMap((action) =>
//      RunsApi.runWithGame(int.parse(action.qrCode)).then((results) {
// //      print("${results}");
//       dynamic json = jsonDecode(results);
//       print("${json}");
//       String runTitle = json['title'];
//       String gameTitle = json['game']['title'];
//       _showDialog(action.context, action.store, gameTitle, runTitle, int.parse(action.qrCode));
//     }).catchError((error) => new SetPage(PageType.login)
// //    {
//       //todo
// //      print('error ${error}');
// //      new SetPage(PageType.login)
// //    }
//     )
//   );
// }

//Stream<AddMeToRun>
// void _showDialog(context, store, game, run, runId) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: new Text(game),
//         content:
//             new Text("${AppLocalizations.of(context).translate('library.participate')}:\n${run}"),
//         actions: <Widget>[
//           new FlatButton(
//             child: new Text(AppLocalizations.of(context).translate('library.cancel')),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           RaisedButton(
//             color: Theme.of(context).accentColor,
//             splashColor: Colors.red,
//             child: Text(
//               AppLocalizations.of(context).translate('library.join'),
//               style: TextStyle(color: Colors.white.withOpacity(0.8)),
//             ),
//             onPressed: () {
//               dispatchAddMeToRun(runId, store, context);
//             },
//           ),
//         ],
//       );
//     },
//   );
// //  return ;
// }

// dispatchAddMeToRun(int runId, store, context) async {
//   Navigator.of(context).pop();
//   store.dispatch(AddMeToRun(runId));
// }

Stream<dynamic> _addMeToRun(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is AddMeToRun).asyncExpand((action) {
    int runId = action.runId;
    return dispatchAddMeToRunActions(
        RunsApi.addMeToRun(runId).then((results) {
//          print("results ${results}");
      dynamic json = jsonDecode(results);
//          print("results ${json}");
      return int.parse(json['gameId']); //, int.parse(json['runId'])];
    }));
  });
}

Stream<dynamic> dispatchAddMeToRunActions(Future<int> data) async* {
  int gameId = (await data);
//  int runId = (await data)[1];
  yield new SetCurrentGameAction(currentGame: gameId);
//  yield new ApiGameAction(gameId);

  yield new SetPage(PageType.myGames);
}

//Stream<dynamic> _loadRunActionStream(Future<dynamic> results) async* {
////  results.then((resultsToDecode) {
//  var resultsList = jsonDecode(await results);
//  List<dynamic> users = resultsList["users"];
//  for (int i = 0; i < users.length; i++) {
//    yield new ApiLoadRunAction(int.parse(users[i]['runId']));
//  }
//}

//
//Stream<dynamic> _runUsers(Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions
//      .where((action) => action is ApiRunsUsersAction)
//      .asyncExpand((action) {
//    return _loadRunActionStream(
//        UsersApi.runUsers(store.state.authentication.idToken)
//            .then((results) => results));
//  });
//}
//
//Stream<dynamic> _addMeToRun2(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions.where((action) => action is AddMeToRun).asyncMap((action) {
//
//    int runId = action.runId;
//    return RunsApi.addMeToRun(runId, store.state.authentication.idToken)
//        .then((results) {
//      print("results ${results}");
//      dynamic json = jsonDecode(results);
//      print("results ${json}");
//      return _dosomeactions(int.parse(json['gameId']));
////      store.dispatch(SetCurrentGameAction(gameId));
////      store.dispatch(ApiGameAction(gameId));
////      store.dispatch(ApiRunsParticipateAction(gameId));
////      store.dispatch(SyncGameContent(gameId));
////      store.dispatch(SetPage(PageType.gameWithRuns));
//
//
//
//    }).catchError((error) {
//      //todo
//    });
//  });
//}
