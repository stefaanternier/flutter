
import 'package:reselect/reselect.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';

var nextItemWithTag =
    (tag) => createSelector2(itemTimesSortedByTime, currentItemId, (List<ItemTimes> items, int? itemId) {
  for (int i = 0; i < items.length; i++) {
    if (items[i].generalItem.dependsOn != null) {
      Dependency? dep = items[i].generalItem.dependsOn;
      if (dep != null && dep is ActionDependency) {
        if (dep.action == tag && dep.generalItemId == itemId) {
          return items[i].generalItem.itemId;
        }
      }
    }
  }
  return null;
});