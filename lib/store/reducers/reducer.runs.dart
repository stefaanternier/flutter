import 'package:redux/redux.dart';
import 'package:youplay/store/actions/actions.collection.dart';
import 'package:youplay/store/actions/actions.runs.dart';

import '../actions/current_run.actions.dart';
import '../state/state.runs.dart';

final runReducer = combineReducers<RunState>([
  TypedReducer<RunState, LoadRunSuccess>((RunState state, LoadRunSuccess action) => state.copyWithNewRun(action.run)),
  TypedReducer<RunState, LoadRunListSuccess>(
      (RunState state, LoadRunListSuccess action) => state.copyWithNewRuns(action.runList.runs)),
  TypedReducer<RunState, SetCurrentRunAction>(
          (RunState state, SetCurrentRunAction action) => state.copyWithNewRun(action.run)),
  TypedReducer<RunState, DeleteRunAction>(
          (RunState state, DeleteRunAction action) => state.deleteRun(action.run)),
  TypedReducer<RunState, LoadGameRunsRequest>(
          (RunState state, LoadGameRunsRequest action) => state.setGameLoadingId(action.gameId)),
  TypedReducer<RunState, CollectionReset>(
          (RunState state, CollectionReset action) => state.setGameLoadingId(null)),
]);
