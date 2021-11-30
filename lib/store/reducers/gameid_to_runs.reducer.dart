import 'dart:collection';

import 'package:redux/redux.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/gameid_to_runs.actions.dart';

final runsReducer = combineReducers<HashMap<int, List<Run>>>([
  new TypedReducer<HashMap<int, List<Run>>, ApiResultRunsParticipateAction>(
      _addParticipateRun),
  new TypedReducer<HashMap<int, List<Run>>, DeleteRunAction>(
      _removeRun),
]);

HashMap<int, List<Run>> _addParticipateRun(
    HashMap<int, List<Run>> oldMap, ApiResultRunsParticipateAction action) {
  HashMap<int, List<Run>> map = HashMap<int, List<Run>>.from(oldMap);
  map[action.gameId] = action.runs
      .where((element) => (!element.deleted))
      .toList(growable: false);
  print ('in reducer (add participate), game run size is now ${map[action.gameId]?.length}');
  return map;
}

HashMap<int, List<Run>> _removeRun(
    HashMap<int, List<Run>> oldMap, DeleteRunAction action) {

  HashMap<int, List<Run>> map = HashMap<int, List<Run>>.from(oldMap);
  map[action.run.gameId] = (map[action.run.gameId]?? [])
      .where((r) => (r.runId != action.run.runId))
      .toList(growable: false);
  print ('in reducer, game run size is now ${map[action.run.gameId]?.length}');
  return map;
}
