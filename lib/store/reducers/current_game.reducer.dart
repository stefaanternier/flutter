
import 'package:redux/redux.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/reducers/ui.reducer.dart';
import 'package:youplay/store/state/all_games_state.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'package:youplay/store/state/run_state.dart';

final Reducer<CurrentGameState> currentGameReducer = combineReducers<CurrentGameState>([
  // new TypedReducer<GamesState, SyncGameContentResult>(_syncGameContentResult),
  // new TypedReducer<CurrentGameState, LoadGameSuccessAction>(_gameSuccesstoGameState),
  // new TypedReducer<CurrentGameState, LoadGameMessagesListResponseAction>(addMessagesToGameState),
  new TypedReducer<CurrentGameState, ApiResultRunsParticipateAction>(_addParticipateRun),
  new TypedReducer<CurrentGameState, ResetRunsAndGoToLandingPage>(_resetAmountOfRuns),
]);


// CurrentGameState _gameSuccesstoGameState( CurrentGameState state, LoadGameSuccessAction action) {
//   if (action.game.title == null) action.game.title = "no title";
//   return state.copyWith(game:action.game);
// }





AppState swapGameState(AppState state, SetCurrentGameAction action) {
  return new AppState(
      // themIdToTheme: state.themIdToTheme,
      // gameIdToGameState: state.gameIdToGameState,
      currentGameState: _initGameState(state.allGamesState, action.currentGame),
//      runIdToRunState: state.runIdToRunState,
      gameIdToRun: state.gameIdToRun,
      gameLibrary: state.gameLibrary,
      // participateGames: state.participateGames,
      allGamesState: state.allGamesState,
      authentication: state.authentication,
      gameThemeState: state.gameThemeState,
      generalItemsState: state.generalItemsState,
      collectionState: state.collectionState,
      gameState: state.gameState,
      runState: state.runState,
      uiState: uiReducer(state.uiState, action),
      currentRunState: CurrentRunState.init()
  );
}

_initGameState(AllGamesState allGamesState, int gameId) {
  if (allGamesState.idToGame[gameId] != null) {
    return new CurrentGameState();
  }
  return CurrentGameState.makeWithGame();

}

CurrentGameState  _addParticipateRun(CurrentGameState state, ApiResultRunsParticipateAction action) {
  return state.copyWith(runAmount: action.runs.where((element) => !element.deleted).length);
}

CurrentGameState  _resetAmountOfRuns(CurrentGameState state, ResetRunsAndGoToLandingPage action) {
  return state.copyWith(runAmount: -1);
}
