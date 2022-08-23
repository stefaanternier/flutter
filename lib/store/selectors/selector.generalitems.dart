import 'package:reselect/reselect.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/state.generalitems.dart';




final generalItemFeatureSelector = (AppState state) => state.generalItemsState;

final Selector<AppState, List<GeneralItem>> currentGameItems = createSelector2(
    currentGameIdState, generalItemFeatureSelector,
        (int? gameId, GeneralItemsState items) {
      return items.entities.values
          .where((element) => element.gameId == gameId && !element.deleted)
          .toList(growable: false);
    }
);

final Selector<AppState, GeneralItem?> currentGeneralItemNew =
createSelector2(generalItemFeatureSelector, currentItemId, (GeneralItemsState items, int? itemId) {
  return items.entities['${itemId}'];
});
