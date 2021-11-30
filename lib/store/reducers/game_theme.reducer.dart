import 'dart:collection';

import 'package:redux/redux.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/game_theme.actions.dart';

final themeIdToThemeReducer = combineReducers<HashMap<int, GameTheme>>([
  new TypedReducer<HashMap<int, GameTheme>, LoadGameThemeSuccess>(_loadTheme),
  new TypedReducer<HashMap<int, GameTheme>, LoadGameSuccessAction>(_loadGameTheme),

]);

HashMap<int, GameTheme> _loadTheme(
    HashMap<int, GameTheme> oldMap, LoadGameThemeSuccess action) {
  HashMap<int, GameTheme> map = HashMap<int, GameTheme>.from(oldMap);
  map[action.gameTheme.themeId] = action.gameTheme;
  return map;
}

HashMap<int, GameTheme> _loadGameTheme(
    HashMap<int, GameTheme> oldMap, LoadGameSuccessAction action) {
  if (action.gameTheme == null) {
    return oldMap;
  }
  HashMap<int, GameTheme> map = HashMap<int, GameTheme>.from(oldMap);
  if (action.gameTheme != null) {
    map[action.gameTheme!.themeId] = action.gameTheme!;
  }
  return map;
}

