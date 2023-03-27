import 'package:redux/redux.dart';
import 'package:youplay/store/actions/actions.games.dart';

import '../state/state.games.dart';

final gameReducer = combineReducers<GameState>([
  TypedReducer<GameState, LoadGameSuccess>((GameState state, LoadGameSuccess action) {

    if (action.game.gameId == 5212115224756224) {
      print("loading game ${action.game.gameId} - ${action.game.title}");
    }
    GameState newGamester = state.copyWithGame(action.game);
    return newGamester;
  }),
  TypedReducer<GameState, LoadGameListSuccess>((GameState state, LoadGameListSuccess action) {
    return state.copyWithGames(action.gameList.items);


}),
]);
