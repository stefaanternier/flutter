
import 'package:reselect/reselect.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/current_game_state.dart';

final Selector<AppState, List<LocationTrigger>> gameLocationTriggers =
createSelector1(currentGameItems, (List<GeneralItem> items) {
  List<LocationTrigger> trigger = [];
  items.forEach((GeneralItem item) {
    if (item.dependsOn != null) {
      List<LocationTrigger> fromItemPoints = item.dependsOn?.locationTriggers() ?? [];
      trigger = [trigger, fromItemPoints].expand((x) => x).toList(growable: true);
    }
  });
  return trigger;
});
