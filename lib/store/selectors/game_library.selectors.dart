import 'package:reselect/reselect.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/game_library.state.dart';

final gameLibraryStateFeature = (AppState state) => state.gameLibrary;
final featuredRunSelector = (AppState state) => state?.gameLibrary?.featuredRun;
final partialSelector = (AppState state) => state.gameLibrary.partialFeaturedGames;
final searchedPartialSelector = (AppState state) => state.gameLibrary.partialSearchedGames;
final allGames = (AppState state) => state.gameLibrary.fullGames;

final Selector<AppState, List<Game>> featuredGamesSelector = createSelector2(
    partialSelector, allGames, (List<Game> partial, Map<int, Game> fullGames) {
  return partial
      .where((game) => fullGames[game.gameId] != null)
      .map((game) => fullGames[game.gameId])
      .toList(growable: false);
});

final Selector<AppState, List<Game>> searchedGamesSelector = createSelector2(
    searchedPartialSelector, allGames, (List<Game> partial, Map<int, Game> fullGames) {
  return partial
      .where((game) => fullGames[game.gameId] != null)
      .map((game) => fullGames[game.gameId])
      .toList(growable: false);
});
