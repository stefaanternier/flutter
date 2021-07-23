import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/actions/errors.dart';
import 'package:youplay/api/games.dart';
import 'package:youplay/store/actions/game_library.actions.dart';
import 'package:youplay/store/actions/game_theme.actions.dart';
import 'package:youplay/store/state/app_state.dart';

Stream<dynamic> _retrieveGameMessages(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .whereType<LoadOneFeaturedGameResultAction>()
      // .where((action) => action is )
      .asyncMap((action) => GamesApi.getTheme(action.game.theme)
      .then((results) => new LoadGameThemeSuccess(gameTheme: results)) //todo check if gameIds when reducing are still current game
      .catchError((error) => new ApiResultError(error: error, message: 'error in retrieve game messages')));
}

final gameThemeEpics = combineEpics<AppState>([
  new TypedEpic<AppState, dynamic>(_retrieveGameMessages),
]);
