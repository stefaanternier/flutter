import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/game_messages.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';

class GameRunsOverviewModel {
  Game currentGame;
  List<Run> runList;
  final Store<AppState> store;

  GameRunsOverviewModel({this.currentGame, this.runList, this.store});

  runTapAction(int index) {
    return () {
      dispatchActions(runList, store, index);
    };
  }

  static GameRunsOverviewModel fromStore(Store<AppState> store) {
    return GameRunsOverviewModel(
        currentGame: gameSelector(store.state.currentGameState),
        runList: currentRunsSelector(store.state),
        store: store);
  }
}

dispatchActions(runList, Store<AppState> store, index) async {
//  store.dispatch(new ApiGameGeneralItems(runList[index].gameId));
  print("dispatching request screens - place 1");


  store.dispatch(SetCurrentRunAction(run: runList[index]));

  // store.dispatch(new LoadGameMessagesListRequestAction()); //1
  // store.dispatch(new ApiRunsVisibleItems(runList[index].runId));
  // store.dispatch(new StartRunAction(runId: runList[index].runId));
  // store.dispatch(new SyncResponsesServerToMobile(
  //     runId: runList[index].runId, from: 1, till: new DateTime.now().millisecondsSinceEpoch));
  // store.dispatch(new SyncActionsServerToMobile(runId: runList[index].runId, from: 1));
  store.dispatch(SetPage(PageType.game));
}
