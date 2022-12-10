import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/actions.error.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/services/collection.api.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import '../actions/actions.collection.dart';
import '../actions/auth.actions.dart';

resetOnError(Stream<dynamic> resetActions, Stream<dynamic> actions) => resetActions
    .where((action) => action is CollectionReset || action is SignOutAction)
    // .debounceTime(new Duration(milliseconds: 2000))
    .switchMap((value) => actions);

final collectionEpics = combineEpics<AppState>([
  TypedEpic<AppState, dynamic>(_loadOneGame),
  TypedEpic<AppState, dynamic>(_getFeaturedGamesEpic),
  TypedEpic<AppState, dynamic>(_getRecentGamesEpic),
  TypedEpic<AppState, dynamic>(_resumeRecentGamesEpic),
]);

Stream<dynamic> _loadOneGame(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
          .whereType<LoadPublicGameRequest>()
          .distinctUnique()
          .asyncMap((action) => CollectionAPI.instance
              .loadOnePublicGame('${action.gameId}')
              .then<dynamic>((Game game) => [LoadPublicGameSuccess(game: game)])
              .catchError((e) => [SetPage(page: PageType.featured), ErrorOccurredAction(e)]))
          .expand((actions) => actions));
}

Stream<dynamic> _getFeaturedGamesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions.whereType<LoadFeaturedGameRequest>().distinctUnique().asyncMap((action) => CollectionAPI.instance
          .featuredGames()
          .then<dynamic>((GameList list) => LoadFeaturedGameSuccess(gameList: list))
          .catchError((_) => CollectionReset())));
}

Stream<dynamic> _getRecentGamesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions.whereType<LoadRecentGameRequest>().distinctUnique().asyncMap((LoadRecentGameRequest action) =>
          CollectionAPI.instance
              .recentGames()
              .then<dynamic>((GameList list) => LoadRecentGamesSuccess(gameList: list))
              .catchError((_) => CollectionReset())));
}

Stream<dynamic> _resumeRecentGamesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<LoadRecentGamesSuccess>()
      .where((action) => action.gameList.resumptionToken != null && action.gameList.items.isNotEmpty)
      .asyncMap((LoadRecentGamesSuccess action) => CollectionAPI.instance
          .resumeGameList(action.gameList.resumptionToken!)
          .then<dynamic>((GameList list) => LoadRecentGamesSuccess(gameList: list))
          .catchError((_) => CollectionReset()));
}
