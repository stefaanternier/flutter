import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/selectors/auth.selectors.dart';
import 'package:youplay/store/selectors/selector.collection.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/pages/play_game_with_native_app.dart';

import 'game_landing.page.loading.dart';
import 'game_landing.page.private.container.dart';
import 'game_landing.page.public.container.dart';

class GameLandingPageContainer extends StatelessWidget {
  int gameId;

  GameLandingPageContainer({required this.gameId, Key? key}) : super(key: key);

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
        if (UniversalPlatform.isWeb && !vm.game!.webEnabled) {
          return PlayAppNativePage();
        }
        if (vm.game!.privateMode) {
          return GameLandingPublicPageContainer(game: vm.game!);
        } else {
          return GameLandingPrivatePageContainer(game: vm.game!);
        }
      },
    );
  }
}

class _ViewModel {
  bool authenticated;
  Game? game;


  _ViewModel({required this.authenticated, this.game});

  static _ViewModel fromStore(Store<AppState> store, int gameId) {
    return _ViewModel(
        authenticated: isAuthenticatedSelector(store.state),
        game: currentGame(store.state) ?? currentCollectionGame(store.state),
        );
  }
}
