import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/store/actions/actions.collection.dart';
import 'package:youplay/store/actions/actions.games.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../models/run.dart';
import '../actions/actions.runs.dart';
import '../services/run.api.dart';
import 'epics.collection.dart';

final runEpics = combineEpics<AppState>([
  TypedEpic<AppState, dynamic>(_gameRunEpics),
  TypedEpic<AppState, dynamic>(_gameRunAuthEpics),
  TypedEpic<AppState, dynamic>(_gameParticipateStream),
  TypedEpic<AppState, dynamic>(_deletePlayerFromRun),
  TypedEpic<AppState, dynamic>(_getRecentRunsEpic),
  TypedEpic<AppState, dynamic>(_getRecentRunUsersEpic)
]);
//
Stream<dynamic> _gameRunEpics(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
      .whereType<LoadRunRequest>()
      .distinctUnique()
      .flatMap((LoadRunRequest action) => RunAPI.instance.getRunUnAuth('${action.runId}'))
      .map((Run run) => LoadRunSuccess(run: run)));
}

Stream<dynamic> _gameRunAuthEpics(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
      .whereType<LoadRunAuthRequest>()
      .distinctUnique()
      .flatMap((LoadRunAuthRequest action) => RunAPI.instance.getRunAuth('${action.runId}'))
      .map((Run run) => LoadRunSuccess(run: run)));
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

Stream<dynamic> _getRecentRunsEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
          .whereType<LoadRecentRunsRequest>()
          .distinctUnique()
          .asyncMap((LoadRecentRunsRequest action) => RunAPI.instance.recentRuns().catchError((_) => CollectionReset()))
          .flatMap((collection) => Stream.fromIterable(collection.items))
          .where((element) =>
              (store.state.runState.entities[element.runId] == null) ||
              (store.state.gameState.entities[element.gameId] == null))
          .expand((element) => [
                if (store.state.runState.entities[element.runId] == null)
                  LoadRunAuthRequest(runId: int.parse(element.runId)),
                if (store.state.gameState.entities[element.gameId] == null) LoadGameRequest(gameId: element.gameId),
              ]));
}

Stream<dynamic> _getRecentRunUsersEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
          .whereType<LoadRecentRunsRequest>()
          .distinctUnique()
          .asyncMap(
              (LoadRecentRunsRequest action) => RunAPI.instance.recentRunsUser().catchError((_) => CollectionReset()))
          .flatMap((collection) => Stream.fromIterable(collection.items))
          .where((event) => !event.deleted)
          .where((element) {
            print('check run and game ${(store.state.runState.entities[element.runId] == null) || (store.state.gameState.entities[element.gameId] == null)} ');
            return (store.state.runState.entities[element.runId] == null) ||
                (store.state.gameState.entities[element.gameId] == null);
          })
          .expand((element) => [
                if (store.state.runState.entities[element.runId] == null)
                  LoadRunAuthRequest(runId: int.parse(element.runId)),
                if (store.state.gameState.entities[element.gameId] == null) LoadGameRequest(gameId: element.gameId),
              ])
          .where((event) {
            print('check filter $event');
            return true;
          }));
}
