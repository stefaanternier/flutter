import 'dart:collection';

import 'package:reselect/reselect.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';

HashMap<int, List<Run>> gameToRunMap(AppState state) => state.gameIdToRun;

final Selector<AppState, List<Run>> currentRunsSelector =
createSelector2(gameToRunMap, currentGameId, (HashMap<int, List<Run>> runs, int? gameId) {
  if (gameId == null || runs[gameId] == null) {
    return [];
  }
  return runs[gameId] ?? [];
});

final Selector<AppState, int> amountOfRunsSelector =
createSelector1(currentRunsSelector, (List<Run> runs) {
  return runs.length;
});

