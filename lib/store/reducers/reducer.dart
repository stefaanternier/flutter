import 'package:youplay/models/models.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/reducers/game_library.reducer.dart';
import 'package:youplay/store/reducers/reducer.gametheme.dart';
import 'package:youplay/store/reducers/ui.reducer.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'all_games.reducer.dart';
import 'auth.reducer.dart';
import 'current_game.reducer.dart';
import 'current_run.reducer.dart';
import 'game_theme.reducer.dart';
import 'gameid_to_runs.reducer.dart';

AppState appReducer(AppState state, action) {
  if (action is SignOutAction) {
    AppState newState = AppState.emptyState();
    newState.gameLibrary = state.gameLibrary;
    newState.gameThemeState = state.gameThemeState;
    newState.uiState.currentPage = PageType.splash;
    return newState;
  }
  if (action is SetCurrentGameAction) {
    return swapGameState(state, action);
  }
  AppState newState = new AppState(
      //themIdToTheme: themeIdToThemeReducer(state.themIdToTheme, action),
      allGamesState: allGamesReducer(state.allGamesState, action),
      // in use: new, same folder
      currentGameState: currentGameReducer(state.currentGameState, action),
      //in use, same folder
      currentRunState: currentRunReducer(state.currentRunState, action),
      gameLibrary: gameLibraryReducer(state.gameLibrary, action),
      // gameIdToGameState: gameReducer(state.gameIdToGameState, action),
      gameIdToRun: runsReducer(state.gameIdToRun, action),
      gameThemeState: gameThemeReducer(state.gameThemeState, action),
      authentication: authenticationReducer(state.authentication, action),
      uiState: uiReducer(state.uiState, action)
  );
  // if (newState == state) {
  //   return state;
  // }
  // print("action changed state ${action.runtimeType} ${newState.hashCode}");
  return newState;
}


