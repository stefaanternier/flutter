import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/services/generalitems.api.dart';
import 'package:youplay/store/state/app_state.dart';

import '../actions/actions.generalitems.dart';

final generalitemEpics = combineEpics<AppState>([
  TypedEpic<AppState, dynamic>(_getGameMessagesEpic),
  TypedEpic<AppState, dynamic>(_resumeGetGameMessagesEpic),
]);

Stream<dynamic> _getGameMessagesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<LoadGameMessagesRequest>()
      .distinctUnique()
      .flatMap((LoadGameMessagesRequest action) => GeneralItemsAPI.instance.getGameMessages(action.gameId))
      .map((GeneralItemList itemsList) => LoadMessageListSuccess(itemsList: itemsList));
}

Stream<dynamic> _resumeGetGameMessagesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<LoadMessageListSuccess>()
      .distinctUnique()
      .where((action) => action.itemsList.items.length > 0)
      .flatMap((LoadMessageListSuccess action) => GeneralItemsAPI.instance
          .resumeGameMessages('${action.itemsList.items[0].gameId}', action.itemsList.resumptionToken))
      .map((GeneralItemList itemsList) => LoadMessageListSuccess(itemsList: itemsList));
}
