import 'package:youplay/actions/errors.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'dart:collection';

import 'package:youplay/store/actions/ui_actions.dart';

UiState uiReducer(UiState state, action) {
  return new UiState(
    gameIdToGame: gameUiReducer(state.gameIdToGame, action),
    currentGameId: myGamesStateReducer(state.currentGameId, action),
    currentItemId: currentItemReducer(state.currentItemId, action),
//      currentRunId : currentRunIdReducer(state.currentRunId,action),
    currentPage: pageReducer(state.currentPage, action),
//      itemUiState: itemUiStateReducer(state.itemUiState, action),
    theme: themeReducer(state.theme, action),
    error: errorReducer(state.error, action),

//      buildContext: errorWithSnackReducer(state.buildContext, action)
  );
}

final gameUiReducer = combineReducers<HashMap<int, GameUiState>>([
  new TypedReducer<HashMap<int, GameUiState>, ToggleMessageViewAction>(_toggleListView),
]);

final myGamesStateReducer = combineReducers<int>([
  new TypedReducer<int, SetCurrentGameAction>(_setCurrentGame),
]);

final currentItemReducer = combineReducers<int>([
  new TypedReducer<int, SetCurrentGeneralItemId>(_setCurrentGeneralItem),
]);

final pageReducer = combineReducers<PageType>([
  new TypedReducer<PageType, SetPage>(_setPageReducer),
]);

final themeReducer = combineReducers<int>([
  new TypedReducer<int, SetTheme>(_setThemeReducer),
]);

final errorReducer = combineReducers<int>([
  new TypedReducer<int, ApiResultError>(_setErrorReducer),
]);

HashMap<int, GameUiState> _toggleListView(
    HashMap<int, GameUiState> oldMap, ToggleMessageViewAction action) {
  HashMap<int, GameUiState> map = HashMap.from(oldMap);
  map.putIfAbsent(action.gameId, () => new GameUiState(messagesView: MessageView.listView));
  if (action.messageView != null) {
    map[action.gameId].messagesView = action.messageView;
  } else if (map[action.gameId].messagesView == MessageView.listView) {
    map[action.gameId].messagesView = MessageView.mapView;
  } else {
    map[action.gameId].messagesView = MessageView.listView;
  }
  return map;
}

int _setCurrentGame(int state, SetCurrentGameAction action) {
  return action.currentGame;
}

int _setCurrentGeneralItem(int state, SetCurrentGeneralItemId action) {
  return action.itemId;
}

PageType _setPageReducer(PageType state, SetPage action) {
  if (action.page == state) return state;
//  print("loading new page ${action.page}");
  return action.page;
}

int _setThemeReducer(int state, SetTheme action) {
  if (action.theme == state) return state;
  return action.theme;
}

int _setErrorReducer(int state, ApiResultError action) {
//  final snackBar = SnackBar(content: Text("${action.message}"));
//
//  Scaffold.of(state.buildContext).showSnackBar(snackBar);

  if (action.error == state) return state;
//  state.error = action.error;
  return state;
}
