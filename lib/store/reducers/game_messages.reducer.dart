
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'dart:collection';

import 'package:youplay/store/actions/game_messages.actions.dart';

GamesState addMessagesToGameState(GamesState state, LoadGameMessagesListResponseAction action) {
  HashMap<int, GeneralItem> itemMap = state.itemIdToGeneralItem;
  if (state.game != null) {
    action.getGeneralItemList(state.game!.gameId).forEach((item) => itemMap[item.itemId] = item);
  }
  return state.copyWith(items: itemMap);
}

