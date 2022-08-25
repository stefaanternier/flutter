import 'package:reselect/reselect.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/state/app_state.dart';

final gameLibraryStateFeature = (AppState state) => state.gameLibrary;
final recentGames = (AppState state) => state.gameLibrary.recentGames;
final partialSelector = (AppState state) => state.gameLibrary.partialFeaturedGames;
final searchedPartialSelector = (AppState state) => state.gameLibrary.partialSearchedGames;
final allGames = (AppState state) => state.gameLibrary.fullGames;

final Selector<AppState, List<Game>> featuredGamesSelectorOld = createSelector2(
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


final Selector<AppState, List<Game>> recentGamesSelectorOld = createSelector1(
    recentGames,  (List<Game> partial) {
      bool isWeb = UniversalPlatform.isWeb;
  return partial
      .where((game) => !isWeb || game.webEnabled )

      .toList(growable: false);
});