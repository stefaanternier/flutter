import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/auth.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import '../../store/actions/actions.generalitems.dart';
import 'run_landing_join.page.dart';

class RunLandingPageJoinContainer extends StatelessWidget {
  final Run run;
  final Game game;

  const RunLandingPageJoinContainer({required this.game, required this.run, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, run, game),
      builder: (context, vm) {
        return RunLandingPageJoin(run: run, game: game, join: vm.join);
      },
    );
  }
}

class _ViewModel {
  final Function() join;

  _ViewModel({
    required this.join,
  });

  static _ViewModel fromStore(Store<AppState> store, Run run, Game game) {
    bool authenticated = isAuthenticatedSelector(store.state);
    return _ViewModel(join: () {
      if (authenticated) {
        store.dispatch(RegisterToRunAction(run: run));
        store.dispatch(LoadGameMessagesRequest(gameId: '${game.gameId}'));
        store.dispatch(SetPage(page: PageType.game, gameId: run.gameId, runId: run.runId));

        store.dispatch(SetMessageViewAction(messageView: game.firstView));
      } else {
        store.dispatch(SetPage(page: PageType.login));
      }

    });
  }
}
