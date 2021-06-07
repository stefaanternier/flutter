import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/state/authentication_state.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'package:youplay/state/library_state.dart';
import 'package:youplay/store/state/run_state.dart';
import 'dart:collection';

import 'package:youplay/state/ui_state.dart';
import 'package:youplay/models/run.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:youplay/store/state/all_games_state.dart';

import 'game_library.state.dart';

class AppState {
  HashMap<int, GameTheme> themIdToTheme;
  HashMap<int, List<Run>> gameIdToRun;
  HashMap<int, GamesState> gameIdToGameState;
  GamesState currentGameState;
  RunState currentRunState;

  GameLibraryState gameLibrary;

//  HashMap<int, RunState> runIdToRunState;
  List<Game> participateGames; //deprecated
  AllGamesState allGamesState;
  UiState uiState;
  FirebaseStorage storage;

//  Library library;
  AuthenticationState authentication;

  AppState({
    this.themIdToTheme,
    this.gameIdToRun,
    this.gameIdToGameState,
    this.currentGameState,
    this.currentRunState,
    this.gameLibrary,
//    this.runIdToRunState,
//    this.library,
    this.authentication,
    this.participateGames,
    this.allGamesState,
    this.uiState,
    this.storage,
  });

  factory AppState.demoState() => new AppState(
        themIdToTheme: new HashMap<int, GameTheme>(),
        gameIdToRun: new HashMap<int, List<Run>>(),
        gameIdToGameState: new HashMap<int, GamesState>(),
        currentGameState: new GamesState(),
//        runIdToRunState: new HashMap<int, RunState>(),
        participateGames: [],
        allGamesState: AllGamesState(participateGames: []),
        authentication: AuthenticationState.unauthenticated(),
        uiState: UiState.initState(),
        gameLibrary: new GameLibraryState(),
      );

  static AppState fromJson(dynamic json) {
    dynamic state = AppState(
      authentication: AuthenticationState.unauthenticated(),
      themIdToTheme: new HashMap<int, GameTheme>(),
//      authentication: AuthenticationState.fromJson(json["authentication"]),
      gameIdToRun: new HashMap<int, List<Run>>(),
      gameIdToGameState: new HashMap<int, GamesState>(),
      currentGameState: new GamesState(),
//      runIdToRunState: new HashMap<int, RunState>(),
      participateGames: [],
      uiState: UiState.initState(),
    );

    (json["participateGames"] as List)
        .forEach((js) => state.participateGames..add(Game.fromJson(js)));

    (json["gameIdToGameState"] as LinkedHashMap<String, dynamic>)
        .forEach((String key, dynamic gamestate) {
      state.gameIdToGameState[int.parse(key)] = GamesState.fromJson(gamestate);
    });
//    (json["runIdToRunState"] as LinkedHashMap<String, dynamic>)
//        .forEach((String key, dynamic runState) {
//      state.runIdToRunState[int.parse(key)] = RunState.fromJson(runState);
//    });

    return state;
  }

  dynamic toJson() {
//    print("serializing appstate");
    dynamic test = this.participateGames.map((game) => game.toJson()).toList(growable: false);
    dynamic gStates = {};
    this.gameIdToGameState.forEach((gameId, state) => gStates["${gameId}"] = state.toJson());
//    dynamic rStates = {};
//    this
//        .runIdToRunState
//        .forEach((runId, state) {
//          if (runId != null) rStates["${runId}"] = state.toJson();
//        });
    dynamic json = {
//      'runIdToRunState': rStates,
      'participateGames': test,
      'authentication': this.authentication.toJson(),
      'gameIdToGameState': gStates
    };
//     print(json);
    return json;
  }
}
