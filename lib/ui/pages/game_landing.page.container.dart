import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.dart';

import 'game_lading.page.unauth-playanon.dart';
import 'game_landing.page.loading.dart';
import 'game_landing.page.login.dart';
import 'game_landing.page.private.container.dart';
import 'game_landing.page.public.container.dart';
import 'game_landing.page.public.dart';


class GameLandingPageContainer extends StatelessWidget {

  int gameId;

  GameLandingPageContainer({
    required this.gameId,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, gameId),
      builder: (context, vm) {

        print("in container");
        if (vm.game == null || vm.game!.gameId != gameId) {
          print("in container null");
          return GameLandingLoadingPage(
            init: vm.loadGame,
            key: ValueKey('loading${gameId}'),
          );
        }
        print("in container before private mode");
        if (vm.game!.privateMode) {
          print("private mode is public  ${vm.game!.privateMode}");
          return GameLandingPublicPageContainer(game: vm.game!);
        } else {
          print("private mode is ${vm.game!.privateMode}");
          return GameLandingPrivatePageContainer(game: vm.game!);
        }
      },
    );
  }
}

class _ViewModel {
  bool authenticated;
  Game? game;
  Function loadGame;

  _ViewModel({required this.authenticated,
    required this.loadGame,
    this.game});

  static _ViewModel fromStore(Store<AppState> store, int gameId) {
    return _ViewModel(
    authenticated: isAuthenticatedSelector(store.state),
      game: gameSelector(store.state.currentGameState),
      loadGame: () {
          store.dispatch(LoadPublicGameRequestAction(gameId: gameId));
      }
    );
  }
}
