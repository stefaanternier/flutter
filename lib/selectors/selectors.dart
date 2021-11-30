import 'dart:collection';

import 'package:reselect/reselect.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/current_game_state.dart';

// HashMap<int, GamesState> gameStateMap(AppState state) => state.gameIdToGameState;

HashMap<int, List<Run>> gameToRunMap(AppState state) => state.gameIdToRun;

//HashMap<int, RunState> runIdToRunState(AppState state) => state.runIdToRunState;

// List<Game> participateState(AppState state) => state.participateGames;

// final Selector<AppState, List<Game>> myGamesList = createSelector1(gameStateMap, (HashMap<int, GamesState> games) {
//   return games.values
//       .toList()
//       .map((gameState) => gameState.game)
//       .where((game) => game != null)
//       .map((game) => game!)
//       .toList(growable: false);
// });

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

var nextItemWithTag =
    (tag) => createSelector2(itemTimesSortedByTime, currentItemId, (List<ItemTimes> items, int? itemId) {
          for (int i = 0; i < items.length; i++) {
            if (items[i].generalItem.dependsOn != null) {
              Dependency? dep = items[i].generalItem.dependsOn;
              if (dep != null && dep is ActionDependency) {
                if (dep.action == tag && dep.generalItemId == itemId) {
                  return items[i].generalItem.itemId;
                }
              }
            }
          }
          return null;
        });

//todo revisit location triggers

final Selector<AppState, List<LocationTrigger>> gameLocationTriggers =
    createSelector1(currentGameSelector, (GamesState game) {
  List<LocationTrigger> trigger = [];
  game.itemIdToGeneralItem.forEach((key, GeneralItem item) {
    if (item.dependsOn != null) {
      List<LocationTrigger> fromItemPoints = item.dependsOn?.locationTriggers() ?? [];
      trigger = [trigger, fromItemPoints].expand((x) => x).toList(growable: true);
    }
  });
  return trigger;
});

