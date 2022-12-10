import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/actions.games.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/auth.selectors.dart';
import 'package:youplay/store/selectors/selector.collection.dart';
import 'package:youplay/store/selectors/selector.runs.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import '../../../store/actions/actions.generalitems.dart';
import 'action-button.dart';

class GameLandingActionButtonContainer extends StatelessWidget {
  const GameLandingActionButtonContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          if (vm.game == null) {
            return Container();
          }
          if (vm.amountOfRuns == 1) {
            return GameActionResumeRun(open: vm.resumeRun);
          }
          if (vm.amountOfRuns > 0) {
            return GameActionOpenRuns(open: vm.openRuns);
          }
          print('vm privatemode is ${vm.game!.privateMode}');
          return GameLandingActionButton(
            showLogin: !vm.game!.privateMode && ((!vm.authenticated || vm.isAnon)),
            open: vm.open,
            login: vm.login,
          );
        });
  }
}

class _ViewModel {
  final Game? game;
  final Store<AppState> store;
  final bool authenticated;
  final bool isAnon;
  final int amountOfRuns;
  final List<Run> runs;

  const _ViewModel({
    required this.authenticated,
    required this.isAnon, required this.game,
    required this.amountOfRuns, required this.store,
    required this.runs,});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isAnon: isAnonSelector(store.state),
      authenticated: isAuthenticatedSelector(store.state),
      game: currentCollectionGame(store.state),
      amountOfRuns: amountOfRunsSelector(store.state),
      runs: currentGameRuns(store.state),
      store: store,
    );
  }

  login() {
    store.dispatch(new SetPage(page: PageType.login));
  }

  open() {
    if (game != null) {
      store.dispatch(new SetPage(page: PageType.gameLandingPage, gameId: game!.gameId));
    }
  }

  openRuns() {
    if (game != null) {
      store.dispatch(new SetPage(page: PageType.gameWithRuns, gameId: game!.gameId));
    }
  }

  resumeRun() {
    if (game != null && this.runs.isNotEmpty) {
      store.dispatch(SetPage(page: PageType.game, gameId: game!.gameId, runId: this.runs.first.runId));
      store.dispatch(LoadGameMessagesRequest(gameId: '${game!.gameId}'));
      store.dispatch(SetMessageViewAction(messageView: game!.firstView));
    }
  }


  createRunAndStart() {
    if (game != null) {
      store.dispatch(new LoadGameRequest(gameId: '${game!.gameId}'));
      store.dispatch(new RequestNewRunAction(gameId: game!.gameId, name: 'demo'));
    }
  }
}
