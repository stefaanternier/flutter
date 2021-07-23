import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

import 'game_landing.page.createanon.dart';
import 'game_landing.page.directstart.dart';
import 'game_landing.page.loading.dart';

class GameLandingPublicPageContainer extends StatelessWidget {
  Game game;

  GameLandingPublicPageContainer({required this.game, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, game),
      builder: (context, vm) {
        if (!vm.authenticated) {
          return GameLandingCreateAnonSessionWaitingPage(
              init: vm.createAnonSession);
        }
        if (vm.amountOfRuns == -1) {
          return GameLandingLoadingPage(
              init: vm.loadRuns,
              text: "Even wachten, we laden de groep(en) voor dit spel...");
        }
        if (vm.amountOfRuns == 0) {
          return GameLandingDirectStartPage(
            game: game,
            createRunAndStart: vm.createRunAndStart,
          );
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
  int amountOfRuns;
  bool isAnon;
  Store<AppState> store;

  _ViewModel(
      {required this.game,
      required this.authenticated,
      required this.isAnon,
      required this.createAnonSession,
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
