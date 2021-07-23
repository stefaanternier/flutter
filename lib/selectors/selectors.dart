import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'dart:collection';
import 'package:reselect/reselect.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/state/run_state.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';

HashMap<int, GamesState> gameStateMap(AppState state) =>
    state.gameIdToGameState;

HashMap<int, List<Run>> gameToRunMap(AppState state) => state.gameIdToRun;

//HashMap<int, RunState> runIdToRunState(AppState state) => state.runIdToRunState;

List<Game> participateState(AppState state) => state.participateGames;

final Selector<AppState, List<Game>> myGamesList =
    createSelector1(gameStateMap, (HashMap<int, GamesState> games) {
  return games.values
      .toList()
      .map((gameState) => gameState.game)
      .where((game) => game != null)
      .map((game) => game!)
      .toList(growable: false);
});

final Selector<AppState, int?> nextItem1 = createSelector2(
    itemTimesSortedByTime, currentItemId, (List<ItemTimes> items, int? itemId) {
  for (int i = 1; i < items.length; i++) {
    if (items[i].generalItem.itemId == itemId) {
      return items[i - 1].generalItem.itemId;
    }
  }
  return null;
});

final Selector<AppState, int> amountOfNewerItems = createSelector2(
    itemTimesSortedByTime, currentItemId, (List<ItemTimes> sortedItems, int? itemId) {
  for (int i = 1; i < sortedItems.length; i++) {
    if (sortedItems[i].generalItem.itemId == itemId) {
      return i;
    }
  }
  return 0;
});



var nextItemWithTag = (tag) =>
    createSelector2(itemTimesSortedByTime, currentItemId,
        (List<ItemTimes> items, int? itemId) {
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
      List<LocationTrigger> fromItemPoints =
          item.dependsOn?.locationTriggers() ?? [];
      trigger =
          [trigger, fromItemPoints].expand((x) => x).toList(growable: true);
    }
  });
  return trigger;
});

// final Selector<AppState, List<LocationTrigger>> gameLocationTriggersOld =
//     createSelector2(gameStateMap, currentGameId,
//         (HashMap<int, GamesState> games, int gameId) {
//   if (games[gameId] == null || games[gameId].game == null) {
//     return [];
//   }
//   List<LocationTrigger> trigger = [];
//   games[gameId].itemIdToGeneralItem.forEach((key, GeneralItem item) {
//     if (item.dependsOn != null) {
//       List<LocationTrigger> fromItemPoints = item.dependsOn.locationTriggers();
//       trigger =
//           [trigger, fromItemPoints].expand((x) => x).toList(growable: true);
//     }
//   });
//   return trigger;
//   //return games[gameId].itemIdToGeneralItem.values.toList();
// });

//final Selector<AppState, GeneralItem> currentGeneralItemDepr =
//    createSelector3(gameStateMap, currentGameId, currentItemId,
//        (HashMap<int, GamesState> games, int gameId, int itemId) {
//  if (games[gameId] == null || games[gameId].game == null) {
//    return new GeneralItem(title: "not loaded");
//  }
//
//  return games[gameId].itemIdToGeneralItem[itemId];
//});

final Selector<AppState, List<Run>> currentRunsSelector = createSelector2(
    gameToRunMap, currentGameId, (HashMap<int, List<Run>> runs, int? gameId) {
  if (gameId == null || runs[gameId] == null) {
    return [];
  }
  return runs[gameId] ?? [];
});

//final Selector<AppState, List<Response>> currentRunResponsesSelector =
//    createSelector1(currentRunStateSelector, (RunState runstate) {
//  return runstate.outgoingResponses;
//});
//
//final Selector<AppState, List<ARLearnAction>> currentRunActionsSelector =
//    createSelector1(currentRunStateSelector, (RunState runstate) {
//  return runstate.unsynchronisedActions;
//});
//
//final Selector<AppState, List<ARLearnAction>> actionsFromServerSelector =
//    createSelector1(currentRunStateSelector, (RunState runstate) {
//  print(
//      "actions from server ${runstate.actionsFromServer.length} ${runstate.run.runId}");
//  return runstate.actionsFromServer.values.toList(growable: false);
//});
//
//final Selector<AppState, List<PictureResponse>>
//    currentRunPictureResponsesSelector =
//    createSelector1(currentRunStateSelector, (RunState runstate) {
//  return runstate.outgoingPictureResponses;
//});

//final Selector<AppState, List<Game>> participateGamesSelector =
//    createSelector2(participateState, gameStateMap,
//        (List<Game> participateGameState, HashMap<int, GamesState> idToState) {
//  List<Game> resultList = new List();
//  participateGameState.forEach((game) {
//    if (idToState[game.gameId] != null && idToState[game.gameId].game != null) {
//      resultList.add(idToState[game.gameId].game);
//    } else {
////          if (game.title == null) game.title = "loading ...";
//      resultList.add(game);
//    }
//  });
//  resultList.sort((game1, game2) {
//    int date1 = game1.lastModificationDate;
//    int date2 = game2.lastModificationDate;
//    return date2.compareTo(date1);
//  });
//  return resultList;
//});

//final Selector<AppState, List<Game>> participateGamesSelector1 =
//    createSelector2(participateState, gameStateMap,
//        (List<Game> participateGameState, HashMap<int, GamesState> idToState) {
////  print("selector participate games 2");
//  List<Game> resultList = new List();
//  idToState.forEach((gameId, gameState) {
//    resultList.add(idToState[gameId].game);
//  });
//
//  resultList.sort((game1, game2) {
//    int date1 = game1.lastModificationDate;
//    int date2 = game2.lastModificationDate;
//    return date2.compareTo(date1);
//  });
//  return resultList;
//});
