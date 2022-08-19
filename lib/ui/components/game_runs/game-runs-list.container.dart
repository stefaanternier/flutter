import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/gameid_to_runs.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/gameid_to_runs.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'game-runs-list.dart';

class GameRunsListContainer extends StatelessWidget {
  const GameRunsListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {
          return GameRunList(
            runList: vm.runList,
            tapRun: vm.tapRun,
            deleteRun: vm.deleteRun,
          );
        });
  }
}

class _ViewModel {
  List<Run> runList;
  Function(int) tapRun;
  final Function(Run) deleteRun;

  _ViewModel({
    required this.runList,
    required this.tapRun,
    required this.deleteRun,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    List<Run> rl = currentRunsSelector(store.state);
    print("run list is ${rl}");

    Game? game = gameSelector(store.state.currentGameState);
    return _ViewModel(
        runList: rl,
        deleteRun: (Run run) {
          store.dispatch(DeleteRunAction(run: run));
        },
        tapRun: (int index) {
          store.dispatch(SetCurrentRunAction(run: rl[index]));
          store.dispatch(SetPage(page: PageType.game));
          if (game != null) {
            store.dispatch(SetMessageViewAction(messageView: game.firstView));
          }
        });
  }
}
