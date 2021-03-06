

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/actions.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/state/authentication_state.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/selectors/authentication_selectors.dart';

import 'game_over.dart';

class GameOverContainer extends StatefulWidget {
  @override
  _GameOverContainerState createState() => _GameOverContainerState();
}

class _GameOverContainerState extends State<GameOverContainer> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return GameOver(
          theme: vm.gameTheme,
          anon: vm.anon,
          startAgain: vm.startAgain,
          toLibrary:  vm.toLibrary,
        );
      },
    );
  }
}

class _ViewModel {
  GameTheme gameTheme;
  bool isAuthenticated;
  bool anon;
  Function startAgain;
  Function toLibrary;

  _ViewModel({
    this.isAuthenticated,
    this.gameTheme,
    this.anon,
    this.startAgain,
    this.toLibrary
  });

  static _ViewModel fromStore(Store<AppState> store) {
    AuthenticationState authenticationState = authenticationInfo(store.state);
    return _ViewModel(
      isAuthenticated: authenticationState.authenticated,
      gameTheme: gameThemeSelector(store.state.currentGameState),
      anon: authenticationState.anon,
      startAgain: () {
         store.dispatch(new EraseAnonAccountAndStartAgain());
         // store.dispatch(AnonymousLoginAction());
         store.dispatch(ResetRunsAndGoToLandingPage());

      },
        toLibrary: () {
          store.dispatch(new EraseAnonAccount());
          store.dispatch(new SetPage(PageType.library));
        }
    );
  }
}