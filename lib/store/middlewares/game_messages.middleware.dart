import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/actions/errors.dart';
import 'package:youplay/api/general_items.dart';
import 'package:youplay/store/actions/game_messages.actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

final gameMessagesEpics = combineEpics<AppState>([
  new TypedEpic<AppState, LoadGameMessagesListRequestAction>(_retrieveGameMessages),
  new TypedEpic<AppState, LoadGameMessagesListResponseAction>(_retrieveCursorMessages),
]);


Stream<dynamic> _retrieveGameMessages(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is LoadGameMessagesListRequestAction)
      .where((action) => currentGameId(store.state) != -1)
      .asyncMap((action) => GeneralItemsApi.generalItemsWithCursor(
      currentGameId(store.state)??-1, '*')
      .then((results) => new LoadGameMessagesListResponseAction(resultAsString: results)) //todo check if gameIds when reducing are still current game
      .catchError((error) => new ApiResultError(error: error, message: 'error in retrieve games')));
}


Stream<dynamic> _retrieveCursorMessages(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is LoadGameMessagesListResponseAction)
      .where((action) => currentGameId(store.state) != -1)
      .where((action) => ((action as LoadGameMessagesListResponseAction).getCursor() != null))
      .asyncMap((action) => GeneralItemsApi.generalItemsWithCursor(
      currentGameId(store.state)?? -1, (action as LoadGameMessagesListResponseAction).getCursor())
      .then((results) => new LoadGameMessagesListResponseAction(resultAsString: results)) //todo check if gameIds when reducing are still current game
      .catchError((error) => new ApiResultError(error: error, message: 'error in retrieve games with cursor')));
}

