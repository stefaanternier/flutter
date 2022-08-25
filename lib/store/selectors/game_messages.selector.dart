import 'package:flutter/material.dart';
import 'package:reselect/reselect.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/selector.gametheme.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/current_game_state.dart';

// final Selector<AppState, bool> isSyncingMessages = createSelector1(gameStateFeature, (CurrentGameState state) {
//   return state.lastSync == null
//       ? false
//       : (state.lastSync!.millisecondsSinceEpoch + 10000 > DateTime.now().millisecondsSinceEpoch);
// });

final Selector<AppState, Color> itemColor = createSelector2(currentGeneralItemNew, currentGameThemeColor,
    (GeneralItem? item, Color defaultColor) => item?.primaryColor ?? defaultColor);
