import 'package:flutter/material.dart';
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

final Selector<AppState, bool> isLoadingCurrentGameRuns =
createSelector2(currentGameIdState, runFeatureSelector,
    (int? gameId, RunState runState) => gameId == runState.loadingGameId);


final Selector<AppState, List<Run>> recentRuns = createSelector1(
    runFeatureSelector,
        (RunState runState) {
          Set<int> runIds = runState.entities.values
        .where((Run element) => !element.deleted)
        .map((Run e) => e.runId!)
          .toSet();

         List<Run> allRuns = runState.entities.values
             .where((Run element) => !element.deleted)
             .toList(growable: false)..sort((r1, r2) => r2.lastModificationDate - r1.lastModificationDate);
          Set<int> uniqueIds = allRuns.map((Run e) => e.gameId).toSet();
          return uniqueIds.map((id) => allRuns.firstWhere((Run element) => element.gameId == id))
            .toList(growable: false)
            ..sort((r1, r2) => r2.lastModificationDate - r1.lastModificationDate);

    });
