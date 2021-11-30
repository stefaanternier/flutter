import 'dart:collection';

import 'package:reselect/reselect.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/state/all_games_state.dart';
import 'package:youplay/store/state/app_state.dart';

final allGamesStateFeature = (AppState state) => state.allGamesState;

final participateGameIdsSelector = (AllGamesState state) => state.participateGames;
final gamesMapSelector = (AllGamesState state) => state.idToGame;
final querySelector = (AllGamesState state) => state.query;
final downloadedGameIdsSelector =
    (AllGamesState state) => state.idToGame.keys.toList(growable: false);

final Selector<AllGamesState, List<int>> unSyncedGames =
createSelector2(participateGameIdsSelector, downloadedGameIdsSelector,
        (List<int> participateIds, List<int> syncedIds) {
      return participateIds.toSet().difference(syncedIds.toSet()).toList(growable: false);
    });

final Selector<AllGamesState, int> firstUnsyncedGameId = createSelector1(
    unSyncedGames, (List<int> ids) => ids.length == 0 ? -1 : ids[0]);

final Selector<AllGamesState, bool> hasUnsyncedGames = createSelector1(
    unSyncedGames, (List<int> ids) => ids.length == 0 ? false : true);

final Selector<AllGamesState, List<Game>> allGames = createSelector2(
    gamesMapSelector, querySelector, (HashMap<int, Game> map, String? query) {
  List<Game> resultList = map.values.toList(growable: false);
  resultList.sort((game1, game2) {
    int date1 = game1.lastModificationDate;
    int date2 = game2.lastModificationDate;
    return date2.compareTo(date1);
  });
  if (query != null) {
    return resultList
      .where((element) => (element.title.toLowerCase().contains(query.toLowerCase())))
      .toList();
  }
  return resultList;
});


