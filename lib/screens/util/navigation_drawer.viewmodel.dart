import 'package:youplay/actions/actions.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/actions/game_library.actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/state/authentication_state.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/selectors/ui_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';

class NavigationViewModel {
  String name;
  String email;

  String accountPicture;
  bool isAuthenticated;
  bool anon;

//  bool showCurrentGame;
  String currentGameTitle;
  String currentRunTitle;
  final Function(PageType) onPageClicked;
  final Function() onLogoutClicked;
  final Function() onAnonErase;


  NavigationViewModel({
        required this.name,
        required this.email,
        required this.accountPicture,
        required this.isAuthenticated,
        required this.anon,
        required this.currentGameTitle,
        required this.currentRunTitle,
        required this.onPageClicked,
        required this.onLogoutClicked,
        required this.onAnonErase
      });

  bool showCurrentGame() {
    return this.currentGameTitle != "" && currentRunTitle != "";
  }

  static NavigationViewModel fromStore(Store<AppState> store) {
    AuthenticationState authenticationState = authenticationInfo(store.state);
    return NavigationViewModel(
        name: authenticationState.name == null ? "" : authenticationState.name,
        email: authenticationState.email == null ? "" : authenticationState.email,
        accountPicture: authenticationState.pictureUrl,
        isAuthenticated: authenticationState.authenticated,
        anon: authenticationState.anon,
        currentGameTitle: currentGameTitleSelector(store.state.currentGameState),
        currentRunTitle: currentRunSelector(store.state.currentRunState)?.title ?? "",
        onPageClicked: (PageType page) {
          store.dispatch(new SetPage(page));

        },
        onAnonErase: () {
          store.dispatch(new EraseAnonAccount());
        },
        onLogoutClicked: () {
          store.dispatch(new SignOutAction());
        });
  }
}
