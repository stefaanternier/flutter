import 'dart:collection';

import 'package:youplay/models/run.dart';
import 'package:youplay/store/state/all_games_state.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'package:youplay/store/state/run_state.dart';
import 'package:youplay/store/state/state.games.dart';
import 'package:youplay/store/state/state.gametheme.dart';
import 'package:youplay/store/state/state.generalitems.dart';
import 'package:youplay/store/state/state.runs.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'auth.state.dart';
import 'game_library.state.dart';
import 'state.collection.dart';

class AppState {
  HashMap<int, List<Run>> gameIdToRun;

  // HashMap<int, GamesState> gameIdToGameState;
  CurrentGameState currentGameState;
  CurrentRunState currentRunState;

  GameLibraryState gameLibrary;
  AllGamesState allGamesState;

  CollectionState collectionState;
  GameState gameState;
  GameThemeState gameThemeState;
  GeneralItemsState generalItemsState;
  RunState runState;

  UiState uiState;

  AuthenticationState authentication;

  AppState(
      {required this.gameIdToRun,
      // required this.gameIdToGameState,
      required this.currentGameState,
      required this.currentRunState,
      required this.gameLibrary,
      required this.authentication,
      // required this.participateGames,
      required this.allGamesState,
      required this.collectionState,
      required this.gameState,
      required this.gameThemeState,
      required this.generalItemsState,
      required this.runState,
      required this.uiState});

  factory AppState.emptyState() => new AppState(
        allGamesState: new AllGamesState(participateGames: []),
        authentication: AuthenticationState.unauthenticated(),
        // themIdToTheme: new HashMap<int, GameTheme>(),
        gameIdToRun: new HashMap<int, List<Run>>(),
        // gameIdToGameState: new HashMap<int, GamesState>(),
        currentGameState: new CurrentGameState(),
        currentRunState: CurrentRunState.init(),
        gameLibrary: GameLibraryState(
          partialFeaturedGames: [],
          partialSearchedGames: [],
          recentGames: [],
          fullGames: new HashMap(),
        ),
        // participateGames: [],
        collectionState: CollectionState.initState(),
        gameState: GameState.initState(),
        gameThemeState: GameThemeState.initState(),
        generalItemsState: GeneralItemsState.initState(),
        runState: RunState.initState(),
        uiState: UiState.initState(),
      );

  static AppState fromJson(dynamic json) {
    AppState state = AppState.emptyState();
    state.authentication = AuthenticationState.fromJson(json['authentication']);
    state.collectionState = CollectionState.fromJson(json['collectionState']);
    state.gameState = GameState.fromJson(json['gameState']);
    state.gameThemeState = GameThemeState.fromJson(json['gameThemeState']);
    print('state was loaded from persistence');
    return state;
  }

  dynamic toJson() {
    dynamic json = {
      'authentication': this.authentication.toJson(),
      'collectionState': this.collectionState.toJson(),
      'gameState': this.gameState.toJson(),
      'gameThemeState': this.gameThemeState.toJson()
    };
    print('json state is ${json}');
    return json;
  }

  @override
  bool operator ==(dynamic other) {
    AppState o = other as AppState;
    bool appChange = (this.allGamesState == other.allGamesState) &&
        (this.currentGameState == other.currentGameState) &&
        (this.currentRunState == other.currentRunState) &&
        (this.gameLibrary == other.gameLibrary) &&
        // (this.gameIdToGameState == other.gameIdToGameState) &&

        (this.gameIdToRun == other.gameIdToRun) &&
        // (this.participateGames == other.participateGames)&&
        (this.authentication == other.authentication) &&
        (this.gameState == other.gameState) &&
        (this.gameThemeState == other.gameThemeState) &&
        (this.generalItemsState == other.generalItemsState) &&
        (this.runState == other.runState) &&
        (this.uiState == other.uiState);

    // if (!appChange) {
    //   print('-- state store ( $appChange)  has changed ${currentRunState.hashCode} -- ${other.currentRunState.hashCode}');
    // }
    return appChange;
  }

  @override
  int get hashCode =>
      allGamesState.hashCode ^
      currentGameState.hashCode ^
      currentRunState.hashCode ^
      gameLibrary.hashCode ^
      gameIdToRun.hashCode ^
      authentication.hashCode ^
      gameState.hashCode ^
      gameThemeState.hashCode ^
      runState.hashCode ^
      uiState.hashCode;
}
