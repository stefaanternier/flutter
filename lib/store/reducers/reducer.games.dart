import 'package:redux/redux.dart';
import 'package:youplay/store/actions/actions.games.dart';

import '../state/state.games.dart';

final gameReducer = combineReducers<GameState>([
  TypedReducer<GameState, LoadGameSuccess>((GameState state, LoadGameSuccess action) {
    print("loading game ${action.game.gameId} - ${action.game.title}");
    return state.copyWithGame(action.game);}),
  TypedReducer<GameState, LoadGameListSuccess>((GameState state, LoadGameListSuccess action) => state.copyWithGames(action.gameList.items)),
]);
