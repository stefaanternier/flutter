import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/game_library.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../localizations.dart';

class GameLandingPageViewModel {
  Game? game;
  GameTheme? gameTheme;
  int amountOfRuns;
  bool isAuth;
  bool isAnon;

  Function tapCustomLogin;
  Function tapPlayAnonymously;
  Function createRunAndStart;
  Function loadRuns;
  Function toRunsPage;

  GameLandingPageViewModel(
      {this.game,
      this.gameTheme,
      required this.amountOfRuns,
      required this.isAuth,
      required this.isAnon,
      required this.tapCustomLogin,
      required this.tapPlayAnonymously,
      required this.createRunAndStart,
      required this.loadRuns,
      required this.toRunsPage});

  static GameLandingPageViewModel fromStore(
      Store<AppState> store, BuildContext context) {
    Game? copyGame = gameSelector(store.state.currentGameState);
    return GameLandingPageViewModel(
        game: gameSelector(store.state.currentGameState),
        gameTheme: gameThemeSelector(store.state.currentGameState),
        amountOfRuns: amountOfRunsSelector(store.state.currentGameState),
        isAuth: isAuthenticatedSelector(store.state),
        isAnon: isAnonSelector(store.state),
        tapCustomLogin: (String email, String password) {
          store.dispatch(CustomAccountLoginAction(
              user: email,
              password: password,
              onError: (String code) {
                final snackBar = SnackBar(content: Text(AppLocalizations.of(context).translate('login.'+code)));

                // final snackBar = SnackBar(content: Text("Error while login"));

                Scaffold.of(context).showSnackBar(snackBar);
                print("show snackbar?");
              },
              onWrongCredentials: () {
                final snackBar = SnackBar(
                    content: Text("Fout! Wachtwoord of email incorrect"));

                Scaffold.of(context).showSnackBar(snackBar);
              },
              onSucces: () {
                if (copyGame != null) {
                  store.dispatch(ApiRunsParticipateAction(copyGame.gameId));
                }
              }));
        },
        tapPlayAnonymously: () {
          store.dispatch(AnonymousLoginAction());
        },
        createRunAndStart: () {
          if (copyGame != null) {
            store.dispatch(
                new RequestNewRunAction(gameId: copyGame.gameId, name: 'demo'));
            store.dispatch(new SetPage(page: PageType.game));
          }
        },
        loadRuns: () {
          if (copyGame != null) {
            store.dispatch(ApiRunsParticipateAction(copyGame.gameId));
          }
        },
        toRunsPage: () {
          store.dispatch(new SetPage(page: PageType.gameWithRuns));
        });
  }
}
