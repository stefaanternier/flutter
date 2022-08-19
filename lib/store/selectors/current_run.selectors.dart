import 'dart:collection';

import 'package:reselect/reselect.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'package:youplay/store/state/run_state.dart';

import 'current_game.selectors.dart';

final runStateFeature = (AppState state) => state.currentRunState;
final responsesFromServerFeature = (AppState state) => state.currentRunState.responsesFromServer;

final runIdSelector = (RunState state) => state.run?.runId ?? -1;
final currentRunSelector = (RunState state) => state.run;
final currentRunSel = (AppState state) => runStateFeature(state) != null ? runStateFeature(state).run : null;

final actionsFromServerSel = (AppState state) => runStateFeature(state).actionsFromServer;
final currentRunActionsSelector = (AppState state) => runStateFeature(state).unsynchronisedActions;
final syncingActionsFromServerSelector = (AppState state) => runStateFeature(state).syncingActionsFromServer;
final responsesFromServerSel = (AppState state) => runStateFeature(state).responsesFromServer;
final currentRunResponsesSelector = (AppState state) => runStateFeature(state).outgoingResponses;
final lastActionModificationSelector = (AppState state) => runStateFeature(state).lastActionModification;
final currentRunPictureResponsesSelector = (AppState state) => runStateFeature(state).outgoingPictureResponses;

final Selector<AppState, HashMap<String, ARLearnAction>> localAndUnsyncActions =
    createSelector2(actionsFromServerSel, currentRunActionsSelector,
        (HashMap<String, ARLearnAction> server, List<ARLearnAction> local) {
  HashMap<String, ARLearnAction> actions = HashMap<String, ARLearnAction>.from(server);
  for (int i = 0; i < local.length; i++) {
    actions[local[i].key] = local[i];
  }
  return actions;
});

final Selector<AppState, bool> isSyncingActions =
    createSelector1(syncingActionsFromServerSelector, (bool state) => state);

final Selector<AppState, bool> correctAnswerGivenSelector =
    createSelector2(localAndUnsyncActions, currentItemId, (HashMap<String, ARLearnAction> actionsFromServer, int? id) {
  return actionsFromServer.containsKey("answer_correct:$id");
});

final Selector<AppState, List<ItemTimes>> itemTimesSortedByTime =
    createSelector3(gameStateFeature, localAndUnsyncActions, lastActionModificationSelector,
        (GamesState gameState, HashMap<String, ARLearnAction> actionsFromServer, int modification) {
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
              .add(ItemTimes(read: item.read(actionsFromServer), generalItem: item, appearTime: localVisibleAt));
        }
      }
    }
  });
  visibleItems.sort((a, b) {
    return b.appearTime.compareTo(a.appearTime);
  });
  return visibleItems;
});

final Selector<AppState, bool> gameHasFinished =
    createSelector3(gameStateFeature, localAndUnsyncActions, lastActionModificationSelector,
        (GamesState gameState, HashMap<String, ARLearnAction> actionsFromServer, int modification) {
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
    return element.generalItem.showInList == null || element.generalItem.showInList;
  }).toList(growable: false);
});

final Selector<AppState, List<ItemTimes>> mapOnlyCurrentGeneralItems =
    createSelector1(itemTimesSortedByTime, (List<ItemTimes> currentGeneralItems) {
  return currentGeneralItems
      .where((element) => element.generalItem.showOnMap == null || element.generalItem.showOnMap)
      .toList(growable: false);
});

final Selector<AppState, List<Response>> currentItemResponsesFromServerAsList =
    createSelector3(runStateFeature, responsesFromServerFeature, currentItemId,
        (dynamic runState, HashMap<int, Response> map, int? itemId) {
  List<Response> fromServer = map.values
      .where((response) => response.generalItemId == itemId)
      .where((response) => runState.deleteList.indexOf(response.responseId) == -1)
      .toList(growable: true);
  fromServer.sort((a, b)=> b.timestamp - a.timestamp);
  return fromServer;
});

final Selector<AppState, int?> nextItem1 =
    createSelector2(itemTimesSortedByTime, currentItemId, (List<ItemTimes> items, int? itemId) {
  for (int i = 1; i < items.length; i++) {
    if (items[i].generalItem.itemId == itemId) {
      return items[i - 1].generalItem.itemId;
    }
  }
  return null;
});

final Selector<AppState, int> amountOfNewerItems =
    createSelector2(itemTimesSortedByTime, currentItemId, (List<ItemTimes> sortedItems, int? itemId) {
  for (int i = 1; i < sortedItems.length; i++) {
    if (sortedItems[i].generalItem.itemId == itemId) {
      return i;
    }
  }
  return 0;
});
