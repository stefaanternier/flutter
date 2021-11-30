import 'package:flutter/material.dart';
import 'package:reselect/reselect.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/current_game_state.dart';

final gameStateFeature = (AppState state) => state.currentGameState;

final gameSelector = (GamesState state) => state.game;
final currentGameSelector = (AppState state) => state.currentGameState;

// final amountOfRunsSelector = (GamesState state) => state.amountOfRuns;

final gameThemeSelector = (GamesState state) => state.gameTheme;
final gameThemePrimaryColorSelector =
    (GamesState state) => state.gameTheme?.primaryColor ?? AppConfig().themeData!.primaryColor;

final gameSelectedSelector =
    (GamesState state) =>  state.game != null;
final currentGameTitleSelector = (GamesState state) => state.game?.title ?? '';

final currentGameId = (AppState state) => gameStateFeature(state).game?.gameId;

final Selector<AppState, Color> gameColor = createSelector1(
    gameStateFeature, (GamesState state) {
  if (state.game == null) {
    return AppConfig().themeData!.primaryColor;
  }
  return state.gameTheme?.primaryColor ?? AppConfig().themeData!.primaryColor;
});