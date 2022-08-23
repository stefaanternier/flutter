
//
// CurrentGameState addMessagesToGameState(CurrentGameState state, LoadGameMessagesListResponseAction action) {
//   HashMap<int, GeneralItem> itemMap = state.itemIdToGeneralItem;
//   if (state.game != null) {
//     action.getGeneralItemList(state.game!.gameId).forEach((item) => itemMap[item.itemId] = item);
//   }
//   print('is last message ${action.getCursor()}');
//   return state.copyWith(
//       items: itemMap, lastSync: action.getCursor() == null ? DateTime.fromMicrosecondsSinceEpoch(0) : DateTime.now());
// }
