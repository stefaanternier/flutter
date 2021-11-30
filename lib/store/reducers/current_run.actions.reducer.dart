import 'dart:collection';

import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/state/run_state.dart';

RunState addLocalAction(RunState state, LocalAction toReduceAction) {
  ARLearnAction action = toReduceAction.getAction();
  if (_actionReplaceNecessary(state.actionsFromServer, action)) {
    state.unsynchronisedActions.add(action);
    state.unsynchronisedActions = List<ARLearnAction>.from(state.unsynchronisedActions);
  }
  return state;
}


RunState addActionsFromServer(RunState state, SyncARLearnActionsListServerToMobileComplete action) {
  bool found = false;
  action.result.responses.forEach((arlearnaction) {
    if (_actionReplaceNecessary(state.actionsFromServer, arlearnaction)) {
      state.actionsFromServer[_actionLookupString(arlearnaction)] = arlearnaction;
      found = true;
    }
  });
  if (found) {
    // if (action.isLast) {
    //   // print('--sync complete');
    // } else {
    //   // print('--sync ongoing');
    // }
    return state.copyWith(a:HashMap<String, ARLearnAction>.from(state.actionsFromServer), isSyncingActions: !action.isLast);
  }
  if (action.isLast) {
    // print('--sync complete ---');
    return state.copyWith(isSyncingActions: !action.isLast);
  }
  return state;
}

RunState resetActions(RunState state, EraseAnonAccountAndStartAgain action) {
  state.actionsFromServer = new HashMap();
  return state.copyWith();
}



RunState addOneActionFromServer(RunState state, SyncActionComplete storeAction) {
  if (storeAction.action == null) {
    return state;
  }
  if (_actionReplaceNecessary(state.actionsFromServer, storeAction.action!)) {
    state.actionsFromServer[_actionLookupString(storeAction.action!)] = storeAction.action!;
    state.actionsFromServer = HashMap<String, ARLearnAction>.from(state.actionsFromServer);
  }
  state.unsynchronisedActions = state.unsynchronisedActions.where((action) =>
      !(storeAction.action!.action == action.action &&
          storeAction.action!.generalItemId == action.generalItemId)).toList(growable: true);
  return state.copyWith(a: state.actionsFromServer);
}

bool _actionReplaceNecessary(HashMap<String, ARLearnAction> map, ARLearnAction action) {
  String lookupString = _actionLookupString(action);
  if (map[lookupString] == null) {
    return true;
  } else {
    if (map[lookupString]!.timestamp > action.timestamp) {
      return true;
    }
  }
  return false;
}

String _actionLookupString(ARLearnAction action) {
  if (action.generalItemId == null) {
    return action.action;
  }
  return "${action.action}:${action.generalItemId}";
}
