import 'package:reselect/reselect.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../models/run.dart';
import '../state/state.runs.dart';

final runFeatureSelector = (AppState state) => state.runState;

final Selector<AppState, List<Run>> currentGameRuns = createSelector2(
    currentGameIdState,
    runFeatureSelector,
    (int? gameId, RunState runState) => runState.entities.values
        .where((element) => element.gameId == gameId && !element.deleted)
        .toList(growable: false));

final Selector<AppState, Run?> currentRun = createSelector2(
    currentRunIdState, runFeatureSelector, (int? runId, RunState runState) => runState.entities['$runId']);

final Selector<AppState, int> amountOfRunsSelector = createSelector1(currentGameRuns, (List<Run> runs) => runs.length);
