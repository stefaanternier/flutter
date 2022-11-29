import 'package:reselect/reselect.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/state.collection.dart';

import '../../models/game.dart';

final collectionSelector = (AppState state) => state.collectionState;

final Selector<AppState, List<Game>> organisationGamesSelector = createSelector2(
    collectionSelector,
    currentPageIdState,
    (CollectionState gameState, int? pageId) {
  List<Game> recentGames =  gameState.entities.values
      .where((element) => !element.deleted)
      .where((Game element) => element.organisationId == '$pageId')
      .toList(growable: false);
  recentGames.sort((a, b) {
    return b.lastModificationDate.compareTo(a.lastModificationDate);
  });
  return recentGames;
});

final Selector<AppState, List<Game>> recentGamesSelector = createSelector1(collectionSelector, (CollectionState gameState) {
  bool isWeb = UniversalPlatform.isWeb;
  List<Game> recentGames =  gameState.entities.values
      .where((element) => !element.deleted)
      .where((element) => gameState.ids.contains(element.id))
      .toList(growable: false);
  recentGames.sort((a, b) {
    return b.lastModificationDate.compareTo(a.lastModificationDate);
  });
  return recentGames;
});

final Selector<AppState, List<Game>> featuredGamesSelector = createSelector1(collectionSelector, (CollectionState gameState) {
  bool isWeb = UniversalPlatform.isWeb;
  List<Game> recentGames =  gameState.entities.values
      .where((element) => !element.deleted)
      .where((element) => gameState.featuredIds.contains(element.id))
      .toList(growable: false);
  recentGames.sort((a, b) {
    return b.lastModificationDate.compareTo(a.lastModificationDate);
  });
  return recentGames;
});

final Selector<AppState, Game?> currentCollectionGame = createSelector2(
    currentGameIdState, collectionSelector, (int? gameId, CollectionState gameState) => gameState.entities['$gameId']);
