import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/services/collection.api.dart';
import 'package:youplay/store/state/app_state.dart';

import '../actions/actions.collection.dart';

final collectionEpics = combineEpics<AppState>([
  TypedEpic<AppState, dynamic>(_getRecentGamesEpic),
]);

Stream<dynamic> _getRecentGamesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<LoadFeaturedGameRequest>()
      .distinctUnique()
      .flatMap((LoadFeaturedGameRequest action) => CollectionAPI.instance.recentGames())
      .map((GameList list) => LoadFeaturedGameSuccess(gameList: list));
}