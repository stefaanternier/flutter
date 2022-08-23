import 'dart:collection';

import 'package:youplay/models/run.dart';

class RunState {
  final Set<String> ids;
  final HashMap<String, Run> entities;

  const RunState({required this.ids, required this.entities});

  static RunState initState() {
    return RunState(ids: <String>{}, entities: HashMap());
  }

  RunState copyWithNewRuns(Iterable<Run> newRuns) {
    return RunState(
      ids: ids..addAll((newRuns).map((e) => e.id)),
      entities: HashMap<String, Run>.from(entities)
        ..addEntries((newRuns).map((e) => MapEntry(e.id, e))),
    );
  }

  RunState copyWithNewRun(Run newRun) {
    return RunState(
      ids: ids..add(newRun.id),
      entities: HashMap<String, Run>.from(entities)
        ..putIfAbsent(newRun.id, () => newRun),
    );
  }

}