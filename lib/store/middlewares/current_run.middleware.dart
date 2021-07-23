import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/api/runs.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/game_messages.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

final currentRunEpic = combineEpics<AppState>([
  new TypedEpic<AppState, RequestNewRunAction>(_requestRun),
  new TypedEpic<AppState, SetCurrentRunAction>(_syncRun),
  new TypedEpic<AppState, RegisterToRunAction>(_registerToRun),

]);

Stream<dynamic> _registerToRun(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is RegisterToRunAction).asyncMap((action) async {
    Run run = await RunsApi.registerToRun((action as RegisterToRunAction).run.runId);

    return new SetCurrentRunAction(run: run);
  });
}

Stream<dynamic> _requestRun(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is RequestNewRunAction).asyncExpand((action) {
    return _createRun(action.gameId, action.name);


    // return new SetCurrentRunAction(run: run);

    // return new SetPage(page: PageType.game, pageId: run.runId);
    //todo
//    store.dispatch(new LoadGameMessagesListRequestAction());
//    store.dispatch(new ApiRunsVisibleItems(runList[index].runId));
//    store.dispatch(new StartRunAction(runId: runList[index].runId));
//    store.dispatch(new SyncResponsesServerToMobile(
//        runId: runList[index].runId, from: 1, till: new DateTime.now().millisecondsSinceEpoch));
//    store.dispatch(new SyncActionsServerToMobile(runId: runList[index].runId, from: 1));
  });
}

Stream<dynamic> _createRun(int gameId, String name) async* {
  Run run = await RunsApi.requestRun(gameId, name);
  yield new SetCurrentRunAction(run: run);
  yield new SetPage(page: PageType.game, pageId: run.runId);
}

Stream<dynamic> _syncRun(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is SetCurrentRunAction).asyncExpand((action) {
    return _runSubtasks(action.run.runId);
  });
}

Stream<dynamic> _runSubtasks(int runId) async* {
  yield new LoadGameMessagesListRequestAction(); //2
  yield new ApiRunsVisibleItems(runId);
  yield new StartRunAction(runId: runId);
  yield new SyncResponsesServerToMobile(
      runId: runId, from: 1, till: new DateTime.now().millisecondsSinceEpoch);
  yield new SyncActionsServerToMobile(runId: runId, from: 1);
}
