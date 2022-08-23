import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../api/run.api.dart';
import '../../models/run.dart';
import '../actions/actions.runs.dart';
import '../actions/current_run.actions.dart';

final runEpics = combineEpics<AppState>([
  TypedEpic<AppState, dynamic>(_gameRunEpics),
  TypedEpic<AppState, dynamic>(_gameParticipateStream)
]);

Stream<dynamic> _gameRunEpics(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<LoadRunRequest>()
      .distinctUnique()
      .flatMap((LoadRunRequest action) => RunAPI.instance.getRunUnAuth('${action.runId}'))
      .map((Run run) => LoadRunSuccess(run: run));
}

Stream<dynamic> _gameParticipateStream(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<ApiRunsParticipateAction>()
      .distinctUnique()
      .flatMap((ApiRunsParticipateAction action) => RunAPI.instance.participate('${action.gameId}'))
      .map((RunList runlist) => LoadRunListSuccess(runList: runlist));
}