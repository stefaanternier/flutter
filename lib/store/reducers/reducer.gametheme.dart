import 'package:redux/redux.dart';
import 'package:youplay/store/state/state.gametheme.dart';

import '../actions/game_theme.actions.dart';

final gameThemeReducer = combineReducers<GameThemeState>([
  TypedReducer<GameThemeState, LoadGameThemeSuccess>(_loadThemes),
]);

GameThemeState _loadThemes(GameThemeState state, LoadGameThemeSuccess action) {
  return state.copyWithNewTheme(action.gameTheme);
}
