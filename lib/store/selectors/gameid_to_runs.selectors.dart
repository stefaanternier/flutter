import 'dart:collection';

import 'package:reselect/reselect.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';

import 'selector.runs.dart';

final Selector<AppState, int> amountOfRunsSelector =
createSelector1(currentGameRuns, (List<Run> runs) {
  return runs.length;
});

