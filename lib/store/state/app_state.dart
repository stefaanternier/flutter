import 'dart:collection';

import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/state/all_games_state.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'package:youplay/store/state/run_state.dart';
import 'package:youplay/store/state/state.gametheme.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'auth.state.dart';
import 'game_library.state.dart';

class AppState {
  HashMap<int, List<Run>> gameIdToRun;

  // HashMap<int, GamesState> gameIdToGameState;
  GamesState currentGameState;
  RunState currentRunState;

  GameLibraryState gameLibrary;
  AllGamesState allGamesState;

  GameThemeState gameThemeState;
  UiState uiState;

  AuthenticationState authentication;

  AppState({
      required this.gameIdToRun,
      // required this.gameIdToGameState,
      required this.currentGameState,
      required this.currentRunState,
      required this.gameLibrary,
      required this.authentication,
      // required this.participateGames,
      required this.allGamesState,
      required this.gameThemeState,
      required this.uiState});

  factory AppState.emptyState() => new AppState(
        allGamesState: new AllGamesState(participateGames: []),
        authentication: AuthenticationState.unauthenticated(),
        // themIdToTheme: new HashMap<int, GameTheme>(),
        gameIdToRun: new HashMap<int, List<Run>>(),
        // gameIdToGameState: new HashMap<int, GamesState>(),
        currentGameState: new GamesState(),
        currentRunState: RunState.init(),
        gameLibrary: GameLibraryState(
          partialFeaturedGames: [],
          partialSearchedGames: [],
          recentGames: [],
          fullGames: new HashMap(),
        ),
        // participateGames: [],
        gameThemeState: GameThemeState.initState(),
        uiState: UiState.initState(),
      );

  static AppState fromJson(dynamic json) {
    AppState state = AppState.emptyState();
    return state;
  }

  dynamic toJson() {
//    print("serializing appstate");
//     dynamic test = this
//         .participateGames
//         .map((game) => game.toJson())
//         .toList(growable: false);
    dynamic gStates = {};
    // this
    //     .gameIdToGameState
    //     .forEach((gameId, state) => gStates["${gameId}"] = state.toJson());
    dynamic json = {
      'authentication': this.authentication.toJson()
      // 'gameIdToGameState': gStates
    };
    return json;
  }

  @override
  bool operator ==(dynamic other) {
    AppState o = other as AppState;
    bool appChange =
        (this.allGamesState == other.allGamesState) &&
        (this.currentGameState == other.currentGameState) &&
        (this.currentRunState == other.currentRunState) &&
        (this.gameLibrary == other.gameLibrary) &&
        // (this.gameIdToGameState == other.gameIdToGameState) &&

        (this.gameIdToRun == other.gameIdToRun) &&
        // (this.participateGames == other.participateGames)&&
        (this.authentication == other.authentication) &&
        (this.gameThemeState == other.gameThemeState) &&
        (this.uiState == other.uiState);

    // if (!appChange) {
    //   print('-- state store ( $appChange)  has changed ${currentRunState.hashCode} -- ${other.currentRunState.hashCode}');
    // }
    return appChange;
  }

  @override
  int get hashCode => allGamesState.hashCode
  ^ currentGameState.hashCode
  ^ currentRunState.hashCode
  ^ gameLibrary.hashCode
  ^ gameIdToRun.hashCode
  ^ authentication.hashCode
  ^ gameThemeState.hashCode
  ^ uiState.hashCode;
}
