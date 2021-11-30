import 'dart:collection';

import 'package:redux/redux.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/errors.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/ui_state.dart';
final uiReducer = combineReducers<UiState>([
  new TypedReducer<UiState, SetCurrentGameAction>(_setCurrentGame),
  new TypedReducer<UiState, SetCurrentGeneralItemId>(_setCurrentGeneralItem),
  new TypedReducer<UiState, SetPage>(_setPageReducer),
  new TypedReducer<UiState, ApiResultError>(_setErrorReducer),
  new TypedReducer<UiState, ToggleMessageViewAction>(_toggleView),
  new TypedReducer<UiState, SetMessageViewAction>(_setView),

]);
//todo cleanup

UiState _setCurrentGame(UiState state, SetCurrentGameAction action) {
  return state.copyWith(newCurrentGame: action.currentGame);
  // return action.currentGame;
}

UiState _setCurrentGeneralItem(UiState state, SetCurrentGeneralItemId action) {
  return state.copyWith(newItemId: action.itemId);
}

UiState _setPageReducer(UiState state, SetPage action) {
  // print("in set page reducer ${action.page} ${action.pageId}");
  if (action.page == state.currentPage) return state;
  return state.copyWith(newPage: action.page, newPageId: action.pageId);
}

// UiState _setThemeReducer(UiState state, SetTheme action) {
//   if (action.theme == state.theme) return state;
//   return state.copyWith(newTheme: action.theme);
// }

UiState _toggleView(UiState state, ToggleMessageViewAction action) {

  return state.toggle(game: action.game);
}

UiState _setView(UiState state, SetMessageViewAction action) {
  return state.copyWith(newView: action.messageView);
}

UiState _setErrorReducer(UiState state, ApiResultError action) {
  if (action.error == state.error) return state;
  return state.copyWith(newError: action.error);
}

// UiState uiReducer(UiState state, action) {
//   return new UiState(
//     gameIdToGame: gameUiReducer(state.gameIdToGame, action),
//     currentGameId: myGamesStateReducer(state.currentGameId, action),
//     currentItemId: currentItemReducer(state.currentItemId, action),
// //      currentRunId : currentRunIdReducer(state.currentRunId,action),
//     currentPage: pageReducer(state.currentPage, action),
// //      itemUiState: itemUiStateReducer(state.itemUiState, action),
//     theme: themeReducer(state.theme, action),
//     error: errorReducer(state.error, action),
//
// //      buildContext: errorWithSnackReducer(state.buildContext, action)
//   );
// }

// final gameUiReducer = combineReducers<HashMap<int, GameUiState>>([
//   new TypedReducer<HashMap<int, GameUiState>, ToggleMessageViewAction>(_toggleListView),
// ]);
//
// final myGamesStateReducer = combineReducers<int>([
//   new TypedReducer<int, SetCurrentGameAction>(_setCurrentGame),
// ]);
//
// final currentItemReducer = combineReducers<int?>([
//   new TypedReducer<int?, SetCurrentGeneralItemId>(_setCurrentGeneralItem),
// ]);
//
// final pageReducer = combineReducers<PageType>([
//   new TypedReducer<PageType, SetPage>(_setPageReducer),
// ]);
//
// final themeReducer = combineReducers<int>([
//   new TypedReducer<int, SetTheme>(_setThemeReducer),
// ]);
//
// final errorReducer = combineReducers<int>([
//   new TypedReducer<int, ApiResultError>(_setErrorReducer),
// ]);

HashMap<int, GameUiState> _toggleListView(
    HashMap<int, GameUiState> oldMap, ToggleMessageViewAction action) {

  return oldMap;
  // HashMap<int, GameUiState> map = HashMap.from(oldMap);
  // GameUiState gameUiState = map[action.gameId] ?? new GameUiState(messagesView: MessageView.listView);
  // map[action.gameId] = map[action.gameId] ?? gameUiState;
  // if (action.messageView != null) {
  //   gameUiState.messagesView = action.messageView!;
  // } else if (gameUiState.messagesView == MessageView.listView) {
  //   gameUiState.messagesView = MessageView.mapView;
  // } else {
  //   gameUiState.messagesView = MessageView.listView;
  // }
  // return map;
}







