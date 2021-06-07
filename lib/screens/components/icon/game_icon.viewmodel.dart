import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/game_theme.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/game_library.selectors.dart';
import 'package:youplay/store/selectors/game_theme.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

class GameIconViewModel {
  Game game;
  GameTheme gameTheme;

  GameIconViewModel({
    this.game,
    this.gameTheme,
  });

  static GameIconViewModel fromStore(Store<AppState> store, BuildContext context, Game game) {
    return GameIconViewModel(
      game: game,
      gameTheme: allThemesSelector(store.state) == null
          ? null
          : allThemesSelector(store.state)[game.theme],
    );
  }

  iconPath() {
    // if (gameTheme == null) {
    //   return '/themes/thema_pict-1-icon.png';
    // }
    return gameTheme?.iconPath;
  }
}
