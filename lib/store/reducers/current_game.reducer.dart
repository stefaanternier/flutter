import 'dart:collection';
import 'dart:convert';

import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/models/game.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/game_messages.actions.dart';
import 'package:youplay/store/reducers/ui.reducer.dart';
import 'package:youplay/store/state/all_games_state.dart';

import 'game_messages.reducer.dart';

final Reducer<GamesState> currentGameReducer = combineReducers<GamesState>([
  new TypedReducer<GamesState, SyncGameContentResult>(_syncGameContentResult),
  new TypedReducer<GamesState, LoadGameSuccessAction>(_gameSuccesstoGameState),
  new TypedReducer<GamesState, LoadGameMessagesListResponseAction>(addMessagesToGameState),
  new TypedReducer<GamesState, ApiResultRunsParticipateAction>(_addParticipateRun),
  new TypedReducer<GamesState, ResetRunsAndGoToLandingPage>(_resetAmountOfRuns),
]);

GamesState _syncGameContentResult( GamesState state, SyncGameContentResult action) {
  GamesState newState = new GamesState();
  newState.game = state.game;
  newState.itemIdToGeneralItem = state.itemIdToGeneralItem;
  newState.gameTheme = state.gameTheme;
  newState.fileIdToGameFile = state.fileIdToGameFile;
  action.gameFiles?.forEach((gamefileJson){
      int fileId = int.parse("${gamefileJson['id']}");
      newState.fileIdToGameFile.putIfAbsent(fileId, ()=> new GameFile(
        path: gamefileJson['path'],
        id: fileId
      ));
  });

  return state;
}

GamesState _gameSuccesstoGameState( GamesState state, LoadGameSuccessAction action) {
//  Map<String, dynamic> gameMap = jsonDecode(action.game);
//  Game game = new Game.fromJson(gameMap);
  if (action.game.title == null) action.game.title = "no title";
  return state.copyWith(game:action.game, gt: action.gameTheme);
}





AppState swapGameState(AppState state, SetCurrentGameAction action) {
  if (state.currentGameState != null && state.currentGameState.game != null) { //backup old game state
    state.gameIdToGameState[state.currentGameState.game.gameId] = state.currentGameState;
  }
  return new AppState(
      themIdToTheme: state.themIdToTheme,
      gameIdToGameState: state.gameIdToGameState,
      currentGameState: state.gameIdToGameState[action.currentGame] ?? _initGameState(state.allGamesState, action.currentGame),
//      runIdToRunState: state.runIdToRunState,
      gameIdToRun: state.gameIdToRun,
      gameLibrary: state.gameLibrary,
      participateGames: state.participateGames,
      allGamesState: state.allGamesState,
      authentication: state.authentication,
      uiState: uiReducer(state.uiState, action),
      storage: state.storage
  );
}

_initGameState(AllGamesState allGamesState, int gameId) {
  if (allGamesState == null && allGamesState.idToGame != null && allGamesState.idToGame[gameId] != null) {
    return new GamesState();
  }
  return GamesState.makeWithGame(allGamesState.idToGame[gameId]);

}

GamesState  _addParticipateRun(GamesState state, ApiResultRunsParticipateAction action) {
  return state.copyWith(runAmount: action.runs.where((element) => !element.deleted).length);
}

GamesState  _resetAmountOfRuns(GamesState state, ResetRunsAndGoToLandingPage action) {
  return state.copyWith(runAmount: -1);
}
