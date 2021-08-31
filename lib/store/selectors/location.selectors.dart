import 'dart:collection';

import 'package:reselect/reselect.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';

final Selector<AppState, List<LocationTrigger>>
    gameMinusActionLocationTriggers = createSelector2(
        gameLocationTriggers, localAndUnsyncActions, (List<LocationTrigger> loc,
            HashMap<String, ARLearnAction> localAndUnsyncActions) {
  // localAndUnsyncActions.keys.forEach((element) {
  //   print('key is $element');
  // });
  List<LocationTrigger>toRet= loc.where((LocationTrigger l) {
    return localAndUnsyncActions['geo:${l.lat}:${l.lng}:${l.radius}'] == null;
  }).toList();
  return toRet;
});
