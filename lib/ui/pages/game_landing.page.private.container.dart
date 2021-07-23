import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';

import '../../localizations.dart';
import 'game_landing.page.createanon.dart';
import 'game_landing.page.directstart.dart';
import 'game_landing.page.loading.dart';
import 'game_landing.page.login.dart';
import 'game_landing.page.loginnecessary.dart';

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
          return GameLandingLoginPage(loginSucces: () {
            setState(() {
              showLogin = false;
              vm.loadRuns();
            });
          });
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
        if (vm.amountOfRuns == -1) {
          return GameLandingLoadingPage(
              init: vm.loadRuns,
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
            init: () {}, text: "amount of runs is ${vm.amountOfRuns}");
      },
    );
  }
}

class _ViewModel {
  Game game;
  bool authenticated;
  Function createAnonSession;
  Function toGameWithRunsPage;
  int amountOfRuns;
  bool isAnon;
  Store<AppState> store;

  _ViewModel(
      {required this.game,
      required this.authenticated,
      required this.isAnon,
      required this.createAnonSession,
      required this.toGameWithRunsPage,
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
      amountOfRuns: amountOfRunsSelector(store.state.currentGameState),
      store: store,
    );
  }

  loadRuns() {
    if (isAnon) {
      // amountOfRuns = 0;
      store.dispatch(
          ApiResultRunsParticipateAction(runs: [], gameId: game.gameId));
    } else {
      store.dispatch(ApiRunsParticipateAction(game.gameId));
    }
  }

  createRunAndStart() {
    store.dispatch(new RequestNewRunAction(gameId: game.gameId, name: 'demo'));
    // store.dispatch(new SetPage(page: PageType.game));
  }
}
