import 'package:redux/redux.dart';
import 'package:youplay/store/actions/game_library.actions.dart';
import 'package:youplay/store/state/game_library.state.dart';

final gameLibraryReducer = combineReducers<GameLibraryState>([
  new TypedReducer<GameLibraryState, LoadFeaturedGameResultsAction>(_featuredGamesReducer),
  new TypedReducer<GameLibraryState, LoadSearchedGameResultsAction>(_searchedGamesReducer),
  new TypedReducer<GameLibraryState, LoadRecentGameResultsAction>(_recentGamesReducer),
  new TypedReducer<GameLibraryState, LoadOneFeaturedGameResultAction>(_loadOneLibraryGameReducer),
  new TypedReducer<GameLibraryState, LoadOneFeaturedRunAction>(_loadOneRunReducer),
]);
//

GameLibraryState _featuredGamesReducer(
    GameLibraryState state, LoadFeaturedGameResultsAction action) {
  return state.copyWith(partialGames: action.games);
}

GameLibraryState _searchedGamesReducer(
    GameLibraryState state, LoadSearchedGameResultsAction action) {
  return state.copyWith(partialSearchedGames: action.games);
}

GameLibraryState _recentGamesReducer(
    GameLibraryState state, LoadRecentGameResultsAction action) {
  return state.copyWith(recentGames: action.games);
}


GameLibraryState _loadOneLibraryGameReducer(
    GameLibraryState state, LoadOneFeaturedGameResultAction action) {
  return state.copyWith(oneGame: action.game);
}

GameLibraryState _loadOneRunReducer(
    GameLibraryState state, LoadOneFeaturedRunAction action) {
  return state.copyWith(oneRun: action.run);
}
