
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/models.dart';

import 'package:youplay/store/state/current_game_state.dart';
import 'package:reselect/reselect.dart';
import 'package:youplay/selectors/ui_selectors.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';

final Selector<AppState, GeneralItem> currentGeneralItem =
    createSelector2(gameStateFeature, currentItemId, (GamesState state, int itemId) {
  if (state == null || state.game == null) {
    return new GeneralItem(title: "not loaded");
  }
  return state.itemIdToGeneralItem[itemId];
});
