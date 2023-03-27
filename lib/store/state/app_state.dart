import 'package:youplay/store/state/all_games_state.dart';
import 'package:youplay/store/state/run_state.dart';
import 'package:youplay/store/state/state.games.dart';
import 'package:youplay/store/state/state.gametheme.dart';
import 'package:youplay/store/state/state.generalitems.dart';
import 'package:youplay/store/state/state.organisation_mappings.dart';
import 'package:youplay/store/state/state.runs.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'auth.state.dart';
import 'state.collection.dart';
import 'state.error.dart';
import 'state.organisation.dart';

class AppState {
  // HashMap<int, GamesState> gameIdToGameState;

  CurrentRunState currentRunState;

  // GameLibraryState gameLibrary;
  AllGamesState allGamesState;

  CollectionState collectionState;
  ErrorState errorState;
  GameState gameState;
  GameThemeState gameThemeState;
  GeneralItemsState generalItemsState;
  OrganisationState organisationState;
  OrganisationMappingState organisationMappingState;
  RunState runState;

  UiState uiState;

  AuthenticationState authentication;

  AppState(
      {required this.currentRunState,
      // required this.gameLibrary,
      required this.authentication,
      // required this.participateGames,
      required this.allGamesState,
      required this.collectionState,
      required this.errorState,
      required this.gameState,
      required this.gameThemeState,
      required this.generalItemsState,
      required this.organisationState,
      required this.organisationMappingState,
      required this.runState,
      required this.uiState});

  factory AppState.emptyState() => new AppState(
        allGamesState: new AllGamesState(participateGames: []),
        authentication: AuthenticationState.unauthenticated(),
        currentRunState: CurrentRunState.init(),
        collectionState: CollectionState.initState(),
        errorState: ErrorState(),
        gameState: GameState.initState(),
        gameThemeState: GameThemeState.initState(),
        generalItemsState: GeneralItemsState.initState(),
        organisationState: OrganisationState.initState(),
        organisationMappingState: OrganisationMappingState.initState(),
        runState: RunState.initState(),
        uiState: UiState.initState(),
      );

  static AppState fromJson(dynamic json) {
    AppState state = AppState.emptyState();
    state.authentication = AuthenticationState.fromJson(json['authentication']);
    state.collectionState = CollectionState.fromJson(json['collectionState']);
    state.gameState = GameState.fromJson(json['gameState']);

    state.organisationState = OrganisationState.fromJson(json['organisationState']);
    state.organisationMappingState = OrganisationMappingState.fromJson(json['organisationMappingState']);
    state.gameThemeState = GameThemeState.fromJson(json['gameThemeState']);

    state.runState = RunState.fromJson(json['runState']);
    print('state was loaded from persistence ${state.runState}');
    print('state was loaded from persistence ${state.runState.entities.length}');

    print('organisationMappingState was loaded from persistence ${state.organisationMappingState}');
    print('organisationMappingState was loaded from persistence ${state.organisationMappingState.entities.length}');
    return state;
  }

  dynamic toJson() {
    dynamic json = {
      'authentication': this.authentication.toJson(),
      'collectionState': this.collectionState.toJson(),
      'gameState': this.gameState.toJson(),
      'organisationState': this.organisationState.toJson(),
      'organisationMappingState': this.organisationMappingState.toJson(),
      'gameThemeState': this.gameThemeState.toJson(),
      'runState': this.runState.toJson()
    };
    // print('saving org ${this.organisationState.toJson()}');
    return json;
  }

  @override
  bool operator ==(dynamic other) {
    AppState o = other as AppState;
    bool appChange = (this.allGamesState == other.allGamesState) &&
        (this.currentRunState == other.currentRunState) &&
        (this.authentication == other.authentication) &&
        (this.collectionState == other.collectionState) &&
        (this.errorState == other.errorState) &&
        (this.gameState == other.gameState) &&
        (this.gameThemeState == other.gameThemeState) &&
        (this.generalItemsState == other.generalItemsState) &&
        (this.organisationState == other.organisationState) &&
        (this.organisationMappingState == other.organisationMappingState) &&
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
      currentRunState.hashCode ^
      authentication.hashCode ^
      collectionState.hashCode ^
      errorState.hashCode ^
      gameState.hashCode ^
      gameThemeState.hashCode ^
      organisationState.hashCode ^
      organisationMappingState.hashCode ^
      runState.hashCode ^
      uiState.hashCode;
}
