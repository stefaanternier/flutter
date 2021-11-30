
import 'package:reselect/reselect.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';


final Selector<AppState, GeneralItem?> nextItemObject = createSelector2(
    itemTimesSortedByTime, currentItemId, (List<ItemTimes> items, int? itemId) {
  for (int i = 1; i < items.length; i++) {
    if (items[i].generalItem.itemId == itemId) {
      return items[i - 1].generalItem;
    }
  }
  return null;
});


final Selector<AppState, List<ItemTimes>> moreRecentThanCurrentItem = createSelector2(
    itemTimesSortedByTime, currentItemId, (List<ItemTimes> items, int? itemId) {
  List<ItemTimes> returnList = [];
  int i = 0;
  while (items[i].generalItem.itemId != itemId && i < items.length) {
    returnList.add(items[i]);
    i++;
  }
  // for (int i = 1; i < items.length; i++) {
  //   if (items[i].generalItem.itemId == itemId) {
  //     return items[i - 1].generalItem;
  //   }
  // }
  return returnList;
});

