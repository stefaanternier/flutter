import 'package:reselect/reselect.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/organisation.dart';
import 'package:youplay/models/organisation_mapping.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/selectors/selector.organisation.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/state.collection.dart';
import 'package:youplay/store/state/state.games.dart';
import 'package:youplay/store/state/state.organisation_mappings.dart';

import '../../models/game.dart';

final collectionSelector = (AppState state) => state.collectionState;
final organisationMappingsSelector = (AppState state) => state.organisationMappingState;

final Selector<AppState, List<Game>> currentOrganisationGamesSelector2 =
    createSelector3(collectionSelector, homeOrganisation, organisationMappingsSelector,
        (CollectionState collectionState, Organisation? organisation, OrganisationMappingState organisationMapping) {
  List<Game> recentGamesIt = organisationMapping.entities.values
      .where((element) => !element.deleted)
      .where((element) => element.organisationId == organisation?.id)
      .map((element) => collectionState.entities[element.gameId])
      .whereType<Game>()
      .toList(growable: false);
  recentGamesIt.sort((a, b) {
    return b.lastModificationDate.compareTo(a.lastModificationDate);
  });
  return recentGamesIt;
});

final Selector<AppState, List<Game>> currentOrganisationPageSelector = createSelector4(
    collectionSelector, currentPageIdState, organisationMappingsSelector, gameFeatureSelector,
    (CollectionState collectionState, int? pageId, OrganisationMappingState organisationMapping, GameState gameState) {
  List<Game> recentGamesIt = organisationMapping.entities.values
      .where((element) => !element.deleted)
      .where((element) => element.organisationId == '$pageId')
      .map((element) => collectionState.entities[element.gameId])
      .whereType<Game>()
      .map((element) => gameState.entities[element.gameId] ?? element)
      .whereType<Game>()
      .toList(growable: false);
  recentGamesIt.sort((a, b) {
    return b.lastModificationDate.compareTo(a.lastModificationDate);
  });
  return recentGamesIt;
});
