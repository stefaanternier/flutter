import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../models/run.dart';
import '../actions/actions.runs.dart';
import '../services/run.api.dart';

final runEpics = combineEpics<AppState>([
  TypedEpic<AppState, dynamic>(_gameRunEpics),
  TypedEpic<AppState, dynamic>(_gameRunAuthEpics),
  TypedEpic<AppState, dynamic>(_gameParticipateStream),
  TypedEpic<AppState, dynamic>(_deletePlayerFromRun)
]);
//
Stream<dynamic> _gameRunEpics(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<LoadRunRequest>()
      .distinctUnique()
      .flatMap((LoadRunRequest action) => RunAPI.instance.getRunUnAuth('${action.runId}'))
      .map((Run run) => LoadRunSuccess(run: run));
}

Stream<dynamic> _gameRunAuthEpics(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<LoadRunAuthRequest>()
      .distinctUnique()
      .flatMap((LoadRunAuthRequest action) => RunAPI.instance.getRunAuth('${action.runId}'))
      .map((Run run) => LoadRunSuccess(run: run));
}

Stream<dynamic> _gameParticipateStream(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<LoadGameRunsRequest>()
      // .distinctUnique()
      .flatMap((LoadGameRunsRequest action) => RunAPI.instance.participate('${action.gameId}'))
      .map((RunList runlist) => LoadRunListSuccess(runList: runlist));
}

Stream<dynamic> _deletePlayerFromRun(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<DeleteRunAction>()
      .flatMap((DeleteRunAction action) => RunAPI.instance.deletePlayerFromRun('${action.run.id}'));
}
