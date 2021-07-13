import 'package:youplay/models/models.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:reselect/reselect.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';

import 'package:youplay/store/selectors/current_run.selectors.dart';

UiState uiState(AppState state) => state.uiState;

PageType currentPageState(AppState state) => state.uiState.currentPage;
//ItemUiState currentItemUiState(AppState state) => state.uiState.itemUiState;
int currentTheme(AppState state) => state.uiState.theme;

int? currentItemId(AppState state) => state.uiState.currentItemId;

final Selector<AppState, MessageView> messagesView =
    createSelector2(uiState, currentGameId, (UiState state, int? gameId) {
  if (state.gameIdToGame[gameId] == null) {
    return MessageView.listView;
  }
  return state.gameIdToGame[gameId]!.messagesView;
});

final Selector<AppState, int> selectTheme =
    createSelector1(currentTheme, (int state) {
  return state;
});

final Selector<AppState, PageType> currentPage =
    createSelector1(currentPageState, (PageType state) {
  return state;
});
