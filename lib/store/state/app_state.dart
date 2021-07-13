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

//  Library library;
  AuthenticationState authentication;

  AppState(
      {required this.themIdToTheme,
      required this.gameIdToRun,
      required this.gameIdToGameState,
      required this.currentGameState,
      required this.currentRunState,
      required this.gameLibrary,
      required this.authentication,
      required this.participateGames,
      required this.allGamesState,
      required this.uiState});

  factory AppState.emptyState() => new AppState(
    allGamesState: new AllGamesState(participateGames: []),
    authentication: AuthenticationState.unauthenticated(),
    themIdToTheme: new HashMap<int, GameTheme>(),
    gameIdToRun: new HashMap<int, List<Run>>(),
    gameIdToGameState: new HashMap<int, GamesState>(),
    currentGameState: new GamesState(),
    currentRunState: new RunState(),
    gameLibrary: GameLibraryState(
      partialFeaturedGames: [],
      partialSearchedGames: [],
      recentGames: [],
      fullGames: new HashMap(),
    ),
    participateGames: [],
    uiState: UiState.initState(),
  );

  static AppState fromJson(dynamic json) {
    AppState state = AppState.emptyState();
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
    dynamic test = this
        .participateGames
        .map((game) => game.toJson())
        .toList(growable: false);
    dynamic gStates = {};
    this
        .gameIdToGameState
        .forEach((gameId, state) => gStates["${gameId}"] = state.toJson());
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
