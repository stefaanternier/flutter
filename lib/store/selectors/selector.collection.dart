import 'package:reselect/reselect.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/state.collection.dart';
import 'package:youplay/store/state/state.games.dart';

import '../../models/game.dart';
import '../../models/run.dart';
import '../state/state.runs.dart';

final collectionSelector = (AppState state) => state.collectionState;

final Selector<AppState, List<Game>> recentGamesSelector = createSelector1(collectionSelector, (CollectionState gameState) {
  return gameState.entities.values.where((element) => !element.deleted).toList(growable: false);
});
