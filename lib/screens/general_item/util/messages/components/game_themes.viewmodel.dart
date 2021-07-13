

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

class GameThemesViewModel {
  GameTheme? gameTheme;

  GameThemesViewModel({this.gameTheme});

  static GameThemesViewModel fromStore(Store<AppState> store) {
    return new GameThemesViewModel(
      gameTheme: gameThemeSelector(store.state.currentGameState),
    );
  }

  Color getPrimaryColor() {
    return gameTheme?.primaryColor ?? AppConfig().themeData!.primaryColor;
  }
}
