import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/actions.games.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/auth.selectors.dart';
import 'package:youplay/store/selectors/selector.collection.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import '../../store/actions/actions.collection.dart';
import 'game_landing.page.directstart.dart';
import 'game_landing.page.loading.dart';

class GamePreLandingPageContainer extends StatelessWidget {
  int gameId;

  GamePreLandingPageContainer({required this.gameId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, gameId),
      builder: (context, vm) {
        if (vm.game == null || vm.game!.gameId != gameId) {
          return GameLandingLoadingPage(
            key: ValueKey('loading${gameId}'),
          );
        }

        return GameLandingDirectStartPage(
          game: vm.game!,
          openDev: vm.openDev,
          close: vm.close,
          createRunAndStart: vm.createRunAndStart,
        );
      },
    );
  }
}

class _ViewModel {
  bool authenticated;
  Game? game;

  Store<AppState> store;

  _ViewModel({required this.authenticated, this.game,
    required this.store});

  static _ViewModel fromStore(Store<AppState> store, int gameId) {
    store.dispatch(LoadPublicGameRequest(gameId: gameId));
    return _ViewModel(
      authenticated: isAuthenticatedSelector(store.state),
      game: currentGame(store.state) ?? currentCollectionGame(store.state),
      store: store
    );
  }

  close() {
    store.dispatch(new SetPage(page: PageType.featured));
  }


  openDev() {
    if (game != null && game!.organisationId != null) {
      store.dispatch(new SetPage(page: PageType.organisationLandingPage, pageId: int.parse(game!.organisationId!)));
    }
  }

  createRunAndStart() {
    if (game != null) {
      store.dispatch(new LoadGameRequest(gameId: '${game!.gameId}'));
      store.dispatch(new RequestNewRunAction(gameId: game!.gameId, name: 'demo'));
    }

  }
}
