import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/selectors/auth.selectors.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/selectors/selector.runs.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/pages/play_game_with_native_app.dart';
import 'package:youplay/ui/pages/run_landing_join.page.container.dart';

import 'game_landing.page.loading.dart';

class RunLandingPageContainer extends StatelessWidget {
  RunLandingPageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        if (vm.game == null || vm.run == null) {
          return GameLandingLoadingPage(
            key: ValueKey('gameLandingLoadingPage'),
          );
        }
        if (UniversalPlatform.isWeb && !vm.game!.webEnabled) {
          return PlayAppNativePage();
        }
        return RunLandingPageJoinContainer(run: vm.run!, game: vm.game!);
      },
    );
  }
}

class _ViewModel {
  final bool authenticated;
  final Game? game;
  final Run? run;

  _ViewModel({required this.authenticated, this.run, this.game});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      authenticated: isAuthenticatedSelector(store.state),
      game: currentGameWithRunId(store.state),
      run: currentRun(store.state),
    );
  }
}
