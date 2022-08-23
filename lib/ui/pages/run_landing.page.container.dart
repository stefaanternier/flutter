import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/selectors/auth.selectors.dart';
import 'package:youplay/store/selectors/game_library.selectors.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/pages/play_game_with_native_app.dart';
import 'package:youplay/ui/pages/run_landing_join.page.container.dart';

import 'game_landing.page.loading.dart';


class RunLandingPageContainer extends StatelessWidget {

  int runId;

  RunLandingPageContainer({
    required this.runId,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, runId),
      builder: (context, vm) {
        if (vm.game == null || vm.run == null) {
          return GameLandingLoadingPage(
            init: vm.loadGame,
            key: ValueKey('loading${runId}'),
          );
        }
        if (UniversalPlatform.isWeb && !vm.game!.webEnabled) {
          return PlayAppNativePage(

          );
        }
        return RunLandingPageJoinContainer(run: vm.run!, game: vm.game!);
      },
    );
  }
}

class _ViewModel {
  bool authenticated;
  Game? game;
  Run? run;
  Function loadGame;

  _ViewModel({required this.authenticated,
    required this.loadGame,
    this.run,
    this.game});

  static _ViewModel fromStore(Store<AppState> store, int runId) {
    return _ViewModel(
        authenticated: isAuthenticatedSelector(store.state),
        game: currentGame(store.state),
        run: featuredRunSelector(store.state),
        loadGame: () {
          print("dispatching LoadPublicRunRequestAction");
          store.dispatch(LoadPublicRunRequestAction(runId: runId));
          // store.dispatch(LoadPublicGameRequestAction(gameId: gameId));
        }
    );
  }
}
