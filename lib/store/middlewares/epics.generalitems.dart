import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/services/generalitems.api.dart';
import 'package:youplay/store/state/app_state.dart';

import '../actions/actions.generalitems.dart';

resetOnError(Stream<dynamic> resetActions, Stream<dynamic> actions) => resetActions.whereType<GiReset>().switchMap((value) => actions);

final generalitemEpics = combineEpics<AppState>([
  TypedEpic<AppState, dynamic>(_getGameMessagesEpic),
  TypedEpic<AppState, dynamic>(_resumeGetGameMessagesEpic),
]);

Stream<dynamic> _getGameMessagesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions.whereType<LoadGameMessagesRequest>().distinctUnique().asyncMap((LoadGameMessagesRequest action) =>
          GeneralItemsAPI.instance
              .getGameMessages(action.gameId)
              .then<dynamic>((GeneralItemList itemsList) => LoadMessageListSuccess(itemsList: itemsList))
              .catchError((_) => GiReset())));
}

Stream<dynamic> _resumeGetGameMessagesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
          .whereType<LoadMessageListSuccess>()
          .distinctUnique()
          .where((action) => action.itemsList.items.length > 0)
          .asyncMap((LoadMessageListSuccess action) => GeneralItemsAPI.instance
              .resumeGameMessages('${action.itemsList.items[0].gameId}', action.itemsList.resumptionToken)
              .then<dynamic>((GeneralItemList itemsList) => LoadMessageListSuccess(itemsList: itemsList))
              .catchError((_) => GiReset())));
}
