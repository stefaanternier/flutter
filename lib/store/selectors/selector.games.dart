import 'package:reselect/reselect.dart';
import 'package:youplay/store/selectors/selector.runs.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/state.games.dart';

import '../../models/game.dart';
import '../../models/run.dart';

final gameFeatureSelector = (AppState state) => state.gameState;

final Selector<AppState, List<Game>> myGames = createSelector1(gameFeatureSelector, (GameState gameState) {
  List<Game> toReturn = gameState.entities.values.where((element) => !element.deleted).toList(growable: false);
  toReturn.sort((a, b) {
    return b.lastModificationDate.compareTo(a.lastModificationDate);
  });
  return toReturn;
});

final Selector<AppState, Game?> currentGame = createSelector2(
    currentGameIdState, gameFeatureSelector, (int? gameId, GameState gameState) => gameState.entities['$gameId']);

final Selector<AppState, Game?> currentGameWithRunId = createSelector2(
    currentRun, gameFeatureSelector, (Run? run, GameState gameState) => gameState.entities['${run?.gameId}']);