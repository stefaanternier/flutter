import 'package:reselect/reselect.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/game_library.state.dart';

final gameLibraryStateFeature = (AppState state) => state.gameLibrary;
final featuredRunSelector = (AppState state) => state.gameLibrary.featuredRun;
final partialSelector = (AppState state) => state.gameLibrary.partialFeaturedGames;
final searchedPartialSelector = (AppState state) => state.gameLibrary.partialSearchedGames;
final allGames = (AppState state) => state.gameLibrary.fullGames;

final Selector<AppState, List<Game>> featuredGamesSelector = createSelector2(
    partialSelector, allGames, (List<Game> partial, Map<int, Game> fullGames) {
  List<Game> list = partial
      .where((game) => fullGames[game.gameId] != null)
      .map((game) => fullGames[game.gameId])
      .where((game)=> game != null)
      .map((game) => game!)
      .toList(growable: false) ;
  list.sort((game1, game2) {
    int date1 = game1.rank ?? 1;
    int date2 = game2.rank ?? 1;
    print("rank $date1 $date2");
    return date1.compareTo(date2);
  });
  return list;
});

final Selector<AppState, List<Game>> searchedGamesSelector = createSelector2(
    searchedPartialSelector, allGames, (List<Game> partial, Map<int, Game> fullGames) {
  return partial
      .where((game) => fullGames[game.gameId] != null)
      .map((game) => fullGames[game.gameId])
      .where((game)=> game != null)
      .map((game) => game!)
      .toList(growable: false);
});
