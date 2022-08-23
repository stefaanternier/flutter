import 'package:reselect/reselect.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/store/state/ui_state.dart';

UiState uiState(AppState state) => state.uiState;

PageType currentPageState(AppState state) => state.uiState.currentPage;
int? currentPageIdState(AppState state) => state.uiState.pageId;
int? currentGameIdState(AppState state) => state.uiState.gameId;
int? currentRunIdState(AppState state) => state.uiState.runId;
int? currentItemIdState(AppState state) => state.uiState.currentItemId;
//ItemUiState currentItemUiState(AppState state) => state.uiState.itemUiState;
int currentTheme(AppState state) => state.uiState.theme;

int? currentItemId(AppState state) => state.uiState.currentItemId;

final Selector<AppState, MessageView> messagesView =
    createSelector1(uiState,  (UiState state) {
  return MessageView.listView;
});

final Selector<AppState, int> selectTheme =
    createSelector1(currentTheme, (int state) {
  return state;
});

final Selector<AppState, PageType> currentPage =
    createSelector1(currentPageState, (PageType state) {
  return state;
});

final Selector<AppState, int?> currentPageId =
createSelector1(currentPageIdState, (int? state) {
  return state;
});

final Selector<AppState, int?> currentItemIdSel =
createSelector1(currentItemIdState, (int? state) {
  return state;
});