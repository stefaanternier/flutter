import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/api/general_items.dart';
import 'package:youplay/api/runs.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/errors.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import '../actions/actions.generalitems.dart';

final currentRunEpic = combineEpics<AppState>([
  new TypedEpic<AppState, RequestNewRunAction>(_requestRun),
  new TypedEpic<AppState, SetCurrentRunAction>(_syncRun),
  new TypedEpic<AppState, RegisterToRunAction>(_registerToRun),
  new TypedEpic<AppState, ApiRunsVisibleItems>(_visibleItems)
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
  });
}

Stream<dynamic> _createRun(int gameId, String name) async* {
  print('create run $gameId -- $name');
  Run run = await RunsApi.requestRun(gameId, name);
  yield LoadGameMessagesRequest(gameId: '$gameId');
  yield new SetCurrentRunAction(run: run);
  yield new SetPage(page: PageType.game, pageId: run.runId, runId: run.runId);
}

Stream<dynamic> _syncRun(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is SetCurrentRunAction).asyncExpand((action) {
    return _runSubtasks(action.run.runId);
  });
}

Stream<dynamic> _runSubtasks(int runId) async* {
  yield new ApiRunsVisibleItems(runId);
  yield new SyncResponsesServerToMobile(
      runId: runId, from: 1, till: new DateTime.now().millisecondsSinceEpoch);
  yield new SyncActionsServerToMobile(runId: runId, from: 1);
}



Stream<dynamic> _visibleItems(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is ApiRunsVisibleItems).asyncMap(
          (action) => GeneralItemsApi.visibleItems(action.runId)
          .then((results) => new ApiResultRunsVisibleItems(results, action.runId))
          .catchError((error) => new ApiResultError(error:error, message: 'error in loading visible items')));
}