import 'package:flutter/material.dart';
import 'package:reselect/reselect.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/current_game_state.dart';

final gameStateFeature = (AppState state) => state.currentGameState;

final gameSelector = (GamesState state) => state.game;
final currentGameSelector = (AppState state) => state.currentGameState;

// final amountOfRunsSelector = (GamesState state) => state.amountOfRuns;

final gameSelectedSelector =
    (GamesState state) =>  state.game != null;
final currentGameTitleSelector = (GamesState state) => state.game?.title ?? '';

final currentGame = (AppState state) => gameStateFeature(state).game;
final currentGameId = (AppState state) => gameStateFeature(state).game?.gameId;
