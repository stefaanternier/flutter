import 'dart:collection';

import 'package:reselect/reselect.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/selectors/ui_selectors.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'package:youplay/store/state/run_state.dart';

import 'current_game.selectors.dart';

final runStateFeature = (AppState state) => state.currentRunState;
final responsesFromServerFeature =
    (AppState state) => state.currentRunState.responsesFromServer;

final runIdSelector = (RunState state) => state.run?.runId ?? -1;
final currentRunSelector = (RunState state) => state.run;
final currentRunSel = (AppState state) =>
    runStateFeature(state) != null ? runStateFeature(state).run : null;

final actionsFromServerSel =
    (AppState state) => runStateFeature(state).actionsFromServer;
final currentRunActionsSelector =
    (AppState state) => runStateFeature(state).unsynchronisedActions;

final responsesFromServerSel =
    (AppState state) => runStateFeature(state).responsesFromServer;

//final currentRunOutgoingPicturesSelector = (AppState state) => runStateFeature(state).outgoingPictureResponses;
final currentRunResponsesSelector =
    (AppState state) => runStateFeature(state).outgoingResponses;

final Selector<AppState, HashMap<String, ARLearnAction>> localAndUnsyncActions =
    createSelector2(actionsFromServerSel, currentRunActionsSelector,
        (HashMap<String, ARLearnAction> server, List<ARLearnAction> local) {
  HashMap<String, ARLearnAction> actions =
      HashMap<String, ARLearnAction>.from(server);
  for (int i = 0; i < local.length; i++) {
    actions["${local[i].action}:${local[i].generalItemId}"] = local[i];
  }
  return actions;
});

final lastActionModificationSelector =
    (AppState state) => runStateFeature(state).lastActionModification;

//final Selector<AppState, List<ARLearnAction>> actionsFromServerSelector =
//    createSelector1(runStateFeature, (RunState runstate) {
//  return runstate.actionsFromServer.values.toList(growable: false);
//});

final currentRunPictureResponsesSelector =
    (AppState state) => runStateFeature(state).outgoingPictureResponses;

final Selector<AppState, bool> correctAnswerGivenSelector =
    createSelector2(localAndUnsyncActions, currentItemId,
        (HashMap<String, ARLearnAction> actionsFromServer, int? id) {
  return actionsFromServer.containsKey("answer_correct:$id");
});

final Selector<AppState, List<ItemTimes>> itemTimesSortedByTime = createSelector3(
    gameStateFeature, localAndUnsyncActions, lastActionModificationSelector,
    (GamesState gameState, HashMap<String, ARLearnAction> actionsFromServer,
        int modification) {
  if (gameState.game == null) {
    return [];
  }
  List<ItemTimes> visibleItems = [];
  gameState.itemIdToGeneralItem.forEach((key, GeneralItem item) {
    int localVisibleAt = item.visibleAt(actionsFromServer);
    int localInvisibleAt = item.disapperAt(actionsFromServer);
    int now = new DateTime.now().millisecondsSinceEpoch;
    // visibleItems.add(ItemTimes(generalItem: item, appearTime: localVisibleAt));
    item.lastModificationDate = localVisibleAt;
    if (localVisibleAt != -1) {
      if (localInvisibleAt == -1 || localInvisibleAt > now) {
        if (item.gameId == gameState.game!.gameId) {
          visibleItems
              .add(ItemTimes(generalItem: item, appearTime: localVisibleAt));
        }
      }
    }
  });
  visibleItems.sort((a, b) {
    return b.appearTime.compareTo(a.appearTime);
  });
  return visibleItems;
});

final Selector<AppState, bool> gameHasFinished = createSelector3(
    gameStateFeature, localAndUnsyncActions, lastActionModificationSelector,
    (GamesState gameState, HashMap<String, ARLearnAction> actionsFromServer,
        int modification) {
  if (gameState.game == null) {
    return false;
  }
  int gameEndsAt = gameState.game!.endsAt(actionsFromServer);
  int now = new DateTime.now().millisecondsSinceEpoch;
  if (gameEndsAt == -1) return false;
  return gameEndsAt < now;
});

final Selector<AppState, List<ItemTimes>> listOnlyCurrentGeneralItems =
    createSelector1(itemTimesSortedByTime, (List<ItemTimes> currentGeneralItems) {
  return currentGeneralItems.where((element) {
    return element.generalItem.showInList == null ||
        element.generalItem.showInList;
  }).toList(growable: false);
});

final Selector<AppState, List<ItemTimes>> mapOnlyCurrentGeneralItems =
    createSelector1(itemTimesSortedByTime, (List<ItemTimes> currentGeneralItems) {
  return currentGeneralItems
      .where((element) =>
          element.generalItem.showOnMap == null ||
          element.generalItem.showOnMap)
      .toList(growable: false);
});

final Selector<AppState, HashMap<int, Response>> responsesFromServerSelector =
    createSelector1(runStateFeature, (RunState run) {
  return run.responsesFromServer;
});

final Selector<AppState, List<Response>> allResponsesFromServerAsList =
    createSelector1(responsesFromServerSelector, (HashMap<int, Response> map) {
  return map.values.toList(growable: false);
});

final Selector<AppState, List<Response>> currentItemResponsesFromServerAsList =
    createSelector3(runStateFeature, responsesFromServerFeature, currentItemId,
        (dynamic runState, HashMap<int, Response> map, int? itemId) {
  return map.values
      .where((response) => response.generalItemId == itemId)
      .where((response) => runState.deleteList.indexOf(response.responseId) == -1)
      .toList(growable: true);
});
