import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';

class ThemedAppBarViewModel {

  Color? itemPrimaryColor;
  Color? themePrimaryColor;


  ThemedAppBarViewModel({ this.itemPrimaryColor, this.themePrimaryColor});

  static ThemedAppBarViewModel fromStore(Store<AppState> store) {
    return new ThemedAppBarViewModel(
      itemPrimaryColor: currentGeneralItem(store.state) == null ? null : currentGeneralItem(store.state)?.primaryColor,
      themePrimaryColor: gameThemePrimaryColorSelector(store.state.currentGameState),
    );
  }

  Color getPrimaryColor() {
    return itemPrimaryColor?? themePrimaryColor ?? AppConfig().themeData!.primaryColor;
  }
}
