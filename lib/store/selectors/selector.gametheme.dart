import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:reselect/reselect.dart';

import '../../models/game.dart';
import '../state/state.gametheme.dart';
import 'current_game.selectors.dart';

final gameThemeStateSelector = (AppState state) => state.gameThemeState;

final Selector<AppState, GameTheme?> currentThemeSelector =
    createSelector2(currentGame, gameThemeStateSelector, (Game? game, GameThemeState gameThemeState) {
  return gameThemeState.entities['${game?.theme ?? 1}'];
});

final Selector<AppState, Color> currentGameThemeColor = createSelector2(
    currentThemeSelector, currentGame,
        (GameTheme? theme, Game? game) {
      if (game == null) {
        return AppConfig().themeData!.primaryColor;
      }
      return theme?.primaryColor ?? AppConfig().themeData!.primaryColor;
    });

