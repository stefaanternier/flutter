import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/auth.selectors.dart';
import 'package:youplay/store/selectors/selector.runs.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import '../../store/actions/actions.games.dart';
import 'game_landing.page.directstart.dart';
import 'game_landing.page.loading.dart';
import 'game_landing.page.loginnecessary.dart';
import 'login_page.dart';

class GameLandingPrivatePageContainer extends StatefulWidget {
  Game game;

  GameLandingPrivatePageContainer({required this.game, Key? key})
      : super(key: key);

  @override
  _GameLandingPrivatePageContainerState createState() =>
      _GameLandingPrivatePageContainerState();
}

class _GameLandingPrivatePageContainerState
    extends State<GameLandingPrivatePageContainer> {
  bool showLogin = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, widget.game),
      builder: (context, vm) {
        if (showLogin) {

          return LoginPage(
            anonLogin: false,
            loginSuccessful: (){
            setState(() {
              showLogin = false;
            });
          },
            anonLoginSuccessful: () {},
          );
        }
        if (!vm.authenticated || vm.isAnon) {
          return GameLandingLoginNecessaryPage(
            game: vm.game,
            login: () {
              setState(() {
                showLogin = true;
              });
            },
          );
        }
        if (vm.loadingRuns) {
          return GameLandingLoadingPage(

              text: "Even wachten, we laden de groep(en) voor dit spel...");
        }
        if (vm.amountOfRuns == 0) {
          return GameLandingDirectStartPage(
            game: widget.game,
            createRunAndStart: vm.createRunAndStart,
          );
        }
        if (vm.amountOfRuns == 1) {
          vm.toGameWithRunsPage();
        } else {
          vm.toGameWithRunsPage();
        }
        return GameLandingLoadingPage(
             text: "${vm.amountOfRuns} groep(en) geladen");
      },
    );
  }
}

class _ViewModel {
  Game game;
  bool authenticated;
  Function createAnonSession;
  Function toGameWithRunsPage;
  bool loadingRuns;
  int amountOfRuns;
  bool isAnon;
  Store<AppState> store;

  _ViewModel(
      {required this.game,
      required this.authenticated,
      required this.isAnon,
      required this.createAnonSession,
      required this.toGameWithRunsPage,
        required this.loadingRuns,
      required this.amountOfRuns,
      required this.store});

  static _ViewModel fromStore(Store<AppState> store, Game game) {
    return _ViewModel(
      game: game,
      authenticated: isAuthenticatedSelector(store.state),
      isAnon: isAnonSelector(store.state),
      createAnonSession: () {
        store.dispatch(AnonymousLoginAction());
      },
      toGameWithRunsPage: () {
        store.dispatch(new SetPage(page: PageType.gameWithRuns));
      },
      loadingRuns: isLoadingCurrentGameRuns(store.state),
      amountOfRuns: amountOfRunsSelector(store.state),
      store: store,
    );
  }

  createRunAndStart() {
    store.dispatch(new LoadGameRequest(gameId: '${game.gameId}'));
    store.dispatch(new RequestNewRunAction(gameId: game.gameId, name: 'demo'));
    // store.dispatch(new SetPage(page: PageType.game));
  }
}
