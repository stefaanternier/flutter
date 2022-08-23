
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/api/StoreApi.dart';
import 'package:youplay/api/games.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/errors.dart';
import 'package:youplay/store/state/app_state.dart';

import '../actions/actions.games.dart';

final currentGameEpic = combineEpics<AppState>([
  // new TypedEpic<AppState, LoadGameRequestAction>(_addGame),
  new TypedEpic<AppState, LoadPublicGameRequestAction>(_addGameFromLibrary),
]);

// Stream<dynamic> _addGame(Stream<dynamic> actions, EpicStore<AppState> store) {
//   return actions
//       .where((action) => action is LoadGameRequestAction)
//       .cast<LoadGameRequestAction>()
//       .flatMap((action) => GamesApi.newGetGame(action.gameId))
//       .map((Game game) async{
//     if (game is ApiResultError) {
//       return game;
//     }
//     return new LoadGameSuccessAction(game: game);
//   });
// }

Stream<dynamic> _addGameFromLibrary(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is LoadPublicGameRequestAction)
     // .distinct((action1, action2) => action1.gameId == action2.gameId)
      .asyncMap((action) async {
    dynamic game = await StoreApi.game(action.gameId);
    if (game is ApiResultError) {
      return game;
    }
    Game g = game as Game;
    return new LoadGameSuccess(game: g); //todo investigate
  });
}
