import 'dart:collection';

import 'package:redux/redux.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/models/run.dart';

final runsReducer = combineReducers<HashMap<int, List<Run>>>([
  new TypedReducer<HashMap<int, List<Run>>, ApiResultRunsParticipateAction>(
      _addParticipateRun),
]);

HashMap<int, List<Run>> _addParticipateRun(
    HashMap<int, List<Run>> oldMap, ApiResultRunsParticipateAction action) {
  HashMap<int, List<Run>> map = HashMap<int, List<Run>>.from(oldMap);
  map[action.gameId] = action.runs
      .where((element) => (element.deleted == null || !element.deleted))
      .toList(growable: false);
  return map;
}
