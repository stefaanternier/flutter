import 'package:reselect/reselect.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../models/run.dart';
import '../state/state.runs.dart';



final runFeatureSelector = (AppState state) => state.runState;


final Selector<AppState, List<Run>> currentGameRuns = createSelector2(
    currentGameIdState, runFeatureSelector,
        (int? gameId, RunState runState) {
          return runState.entities.values
              .where((element) => element.gameId == gameId && !element.deleted)
              .toList(growable: false);
        }
);

