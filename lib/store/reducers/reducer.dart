import 'package:youplay/actions/actions.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/reducers/games_reducer.dart';
import 'package:youplay/reducers/runs_reducer.dart';
import 'package:youplay/reducers/authentication_reducer.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/reducers/game_library.reducer.dart';
import 'package:youplay/store/reducers/ui.reducer.dart';

import 'all_games.reducer.dart';
import 'current_game.reducer.dart';
import 'current_run.reducer.dart';
import 'game_theme.reducer.dart';

AppState appReducer(AppState state, action) {
  if (action is SignOutAction) {
    AppState newState = AppState.emptyState();
    newState.gameLibrary = state.gameLibrary;
    newState.themIdToTheme = state.themIdToTheme;
    return newState;
  }
  if (action is SetCurrentGameAction) {
    return swapGameState(state, action);
  }
  AppState newState = new AppState(
//    profile: profileReducer(state.profile, action),
//    games: gamesReducer(state.games, action),
      themIdToTheme: themeIdToThemeReducer(state.themIdToTheme, action),
      allGamesState: allGamesReducer(state.allGamesState, action),
      // in use: new, same folder
      currentGameState: currentGameReducer(state.currentGameState, action),
      //in use, same folder
      currentRunState: currentRunReducer(state.currentRunState, action),
      gameLibrary: gameLibraryReducer(state.gameLibrary, action),
      gameIdToGameState: gameReducer(state.gameIdToGameState, action),
      gameIdToRun: runsReducer(state.gameIdToRun, action),
      //in use

      participateGames: participateGames(state.participateGames, action),

//      library: libraryReducer(state.library, action),

      authentication: authenticationReducer(state.authentication, action),
      uiState: uiReducer(state.uiState, action)
  );
  // if (newState == state) {
  //   return state;
  // }
  print("action changed state ${action.runtimeType} ${newState.hashCode}");
  return newState;
}


