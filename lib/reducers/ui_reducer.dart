import 'package:youplay/actions/errors.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/games.dart';
import 'dart:collection';

//
//UiState uiReducer(UiState state, action) {
//  return new UiState(
//      gameIdToGame: gameUiReducer(state.gameIdToGame, action),
//      currentGameId: myGamesStateReducer(state.currentGameId,action),
//      currentItemId: currentItemReducer(state.currentItemId,action),
////      currentRunId : currentRunIdReducer(state.currentRunId,action),
//      currentPage: pageReducer(state.currentPage,action),
////      itemUiState: itemUiStateReducer(state.itemUiState, action),
//      theme: themeReducer(state.theme,action),
//      error: errorReducer(state.error, action),
//
////      buildContext: errorWithSnackReducer(state.buildContext, action)
//  );
//}
//SetCurrentRunAction
//final currentRunIdReducer = combineReducers<int>([
//  new TypedReducer<int, SetCurrentRunAction>(_setCurrentRunIdReducer),
//
//]);
//
//int _setCurrentRunIdReducer(int state, SetCurrentRunAction action) {
//  return action.runId;
//}

//final gameUiReducer = combineReducers<HashMap<int, GameUiState>>([
//  new TypedReducer<HashMap<int, GameUiState>, ShowMapViewAction>(_mapView),
//  new TypedReducer<HashMap<int, GameUiState>, ShowListViewAction>(_listView),
//]);


//HashMap<int, GameUiState> _mapView(HashMap<int, GameUiState>   oldMap, ShowMapViewAction action) {
////  print("reducing mapv");
//  HashMap<int, GameUiState> map = HashMap.from(oldMap);
//
//  map.putIfAbsent(action.gameId, ()=> new GameUiState(messagesView:1));
//  map[action.gameId].messagesView = 1;
////  print("${map[2517058].messagesView}");
//  return map;
//}
//
//HashMap<int, GameUiState> _listView(HashMap<int, GameUiState>   oldMap, ShowListViewAction action) {
//  HashMap<int, GameUiState> map = HashMap.from(oldMap);
//  map.putIfAbsent(action.gameId, ()=> new GameUiState(messagesView:2));
//  map[action.gameId].messagesView = 2;
//  return map;
//}

//final myGamesStateReducer = combineReducers<int>([
//  new TypedReducer<int, SetCurrentGameAction>(_setCurrentGame),
//]);

//int _setCurrentGame(int state, SetCurrentGameAction action) {
//  return action.currentGame;
//}

//final currentItemReducer = combineReducers<int>([
//  new TypedReducer<int, SetCurrentGeneralItemId>(_setCurrentGeneralItem),
//
//]);

int _setCurrentGeneralItem(int state, SetCurrentGeneralItemId action) {
  return action.itemId;
}


//
//final pageReducer = combineReducers<PageType>([
//  new TypedReducer<PageType, SetPage>(_setPageReducer),
//
//]);
//
//
//
//PageType _setPageReducer(PageType state, SetPage action) {
//  if (action.page == state) return state;
////  print("loading new page ${action.page}");
//  return action.page;
//}

//final itemUiStateReducer = combineReducers<ItemUiState>([
//  new TypedReducer<ItemUiState, GeneralItemTakePicture>(_setItemUiStateReducer),
//  new TypedReducer<ItemUiState, GeneralItemCancelDataCollection>(_setGeneralItemCancelDC),
//
//]);
//
//
//ItemUiState _setItemUiStateReducer(ItemUiState state, GeneralItemTakePicture action) {
//  return ItemUiState.takePicture;
//}
//
//ItemUiState _setGeneralItemCancelDC(ItemUiState state, GeneralItemCancelDataCollection action) {
//  return ItemUiState.itemView;
//}

//final themeReducer = combineReducers<int>([
//  new TypedReducer<int, SetTheme>(_setThemeReducer),
//
//]);
//
//int _setThemeReducer(int state, SetTheme action) {
//  if (action.theme == state) return state;
//  return action.theme;
//}
//
//final errorReducer = combineReducers<int>([
//  new TypedReducer<int, ApiResultError>(_setErrorReducer),
//
//]);
//
//int _setErrorReducer(int state, ApiResultError action) {
////  final snackBar = SnackBar(content: Text("${action.message}"));
////
////  Scaffold.of(state.buildContext).showSnackBar(snackBar);
//
//  if (action.error == state) return state;
////  state.error = action.error;
//  return state;
//}
//
//
//final errorWithSnackReducer = combineReducers<BuildContext>([
//  new TypedReducer<BuildContext, ApiResultError>(_setbuildcontextReducer),
//
//]);
//
//BuildContext _setbuildcontextReducer(BuildContext state, ApiResultError action) {
//
//
//  return state;
//}
