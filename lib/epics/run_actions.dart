import 'dart:collection';
import 'dart:convert';

import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/api/actions.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/state/run_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';


//todo delete this file

//final syncOutgoingActions =
//    new TypedEpic<AppState, SyncOutgoingActions>(_syncOutgoingActions);

//Stream<dynamic> _syncOutgoingActions(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions
//      .where((action) => action is SyncOutgoingActions)
//      .asyncMap((action) {
//    int runId = runIdSelector(store.state.currentRunState);//store.state.uiState.currentRunId;
//    List<ARLearnAction> actions =
//        store.state.runIdToRunState[runId].unsynchronisedActions;
//    print("syncing actions ${actions.length}");
//    if (actions.length > 0) {
//      ARLearnAction submitAction = actions.removeLast();
//      return ActionsApi.submitAction(
//              submitAction, store.state.authentication.idToken)
//          .then((results) {
//        return new SyncOutgoingActions();
//      }).catchError((error) {
//        actions..add(submitAction);
//      });
//    } else {
//      new SyncIncommingActions();
//    }
//  });
//}

//final syncIncommingActions =
//    new TypedEpic<AppState, SyncIncommingActions>(_syncIncommingActions);

//Stream<dynamic> _syncIncommingActions(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions
//      .where((action) => action is SyncIncommingActions)
//      .asyncMap((action) {
//    SyncIncommingActions inCommingActionSync = action as SyncIncommingActions;
//    int runId =  runIdSelector(store.state.currentRunState); //store.state.uiState.currentRunId;
//    RunState runState = store.state.runIdToRunState[runId];
//
//    int lastSync = runState.lastSync;
//    if (inCommingActionSync.fromTime != null)
//      lastSync = inCommingActionSync.fromTime;
//    print(
//        "incomminga ${inCommingActionSync.resumptionToken} ${runId} ${lastSync}");
//    if (inCommingActionSync.resumptionToken != null) {
//      return ActionsApi.getActions(
//              runId,
//              lastSync,
//              inCommingActionSync.resumptionToken,
//              store.state.authentication.idToken)
//          .then((json) {
////        print("json ${json}");
//
//        if (inCommingActionSync.resumptionToken == "-")
//          runState.lastSync = int.parse(json["serverTime"]);
//        List<ARLearnAction> aFromServer = [];
//        if (json["actions"] != null) {
//          (json["actions"] as List)
//              .forEach((json) => aFromServer.add(ARLearnAction.fromJson(json)));
//
//          return new SyncIncommingActions(
//              runId: runId,
//              fromTime: lastSync,
//              resumptionToken: json["resumptionToken"],
//              actionsFromServer: aFromServer);
//        }
//      });
//    }
//  });
//}
