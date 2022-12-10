import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/actions.organisation_mappings.dart';
import 'package:youplay/store/services/game.api.dart';
import 'package:youplay/store/services/organisation.api.dart';
import 'package:youplay/store/state/app_state.dart';

import '../actions/actions.games.dart';
import '../actions/all_games.actions.dart';
import 'epics.collection.dart';

final gameEpics = combineEpics<AppState>([
  TypedEpic<AppState, dynamic>(_getGameEpic),
  TypedEpic<AppState, dynamic>(_getGameFromRunEpic),
  TypedEpic<AppState, dynamic>(_getGameFromRunEpicUnAuth),
  TypedEpic<AppState, dynamic>(_getParticipateGamesEpic),
  TypedEpic<AppState, dynamic>(_getOrganisationGamesEpic),
]);
//
Stream<dynamic> _getGameEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
          .whereType<LoadGameRequest>()
          .distinctUnique()
          .flatMap((LoadGameRequest action) => GameAPI.instance.getGame(action.gameId))
          .map((Game game) => LoadGameSuccess(game: game)));
}

Stream<dynamic> _getGameFromRunEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
      .whereType<LoadGameFromRunRequest>()
      .distinctUnique()
      .flatMap((LoadGameFromRunRequest action) => GameAPI.instance.getGameFromRun(action.runId))
      .map((Game game) => LoadGameSuccess(game: game)));
}

Stream<dynamic> _getGameFromRunEpicUnAuth(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
      .whereType<LoadGameFromRunUnAuthRequest>()
      .distinctUnique()
      .flatMap((LoadGameFromRunUnAuthRequest action) => GameAPI.instance.getGameFromRunUnAuth(action.runId))
      .map((Game game) => LoadGameSuccess(game: game)));
}

Stream<dynamic> _getParticipateGamesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
      .whereType<LoadParticipateGamesListRequestAction>()
      .distinctUnique()
      .flatMap((LoadParticipateGamesListRequestAction action) => GameAPI.instance.getParticipateGameIds())
      .map((String gameId) => LoadGameRequest(gameId: gameId)));
}

Stream<dynamic> _getOrganisationGamesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<LoadGameFromOrganisationRequest>()
      .asyncMap((LoadGameFromOrganisationRequest action) => OrgAPI.instance.orgMappings(action.organisationId))
      .expand((col) => []
        ..addAll(col.items.map((mapping) => LoadGameRequest(gameId: mapping.gameId)))
        ..add(LoadOrganisationMappingsSuccess(organisationMappings: col)));
  // .map((GameList gameList) => LoadGameListSuccess(gameList: gameList));
}
