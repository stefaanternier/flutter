
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/api/actions.dart';
import 'package:youplay/api/games.dart';
import 'package:youplay/api/runs.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/errors.dart';
import 'package:youplay/store/actions/game_library.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import '../actions/actions.games.dart';

final uploadActionEpic = new TypedEpic<AppState, LocalAction>(_postAction);
final loadPublicRunEpic = new TypedEpic<AppState, LoadPublicRunRequestAction>(_loadPublicRun);

final runsParticipateEpic =
new TypedEpic<AppState, ApiRunsParticipateAction>(_gameParticipateStream);

Stream<dynamic> _gameParticipateStream(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is ApiRunsParticipateAction)
      .asyncMap((action) {
    if (AppConfig().analytics != null) {
      AppConfig().analytics!.logJoinGroup(groupId: '${action.gameId}');
    }
    return RunsApi.participate(action.gameId).then((results) =>
    new ApiResultRunsParticipateAction(
        runs: results, gameId: action.gameId));
  });
}

//dispatched from take picture

Stream<dynamic> _postAction(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) =>
          action is LocalAction || (action is SyncActionComplete && action.action != null))
      .asyncMap(((action) async {
    if (!store.state.currentRunState.unsynchronisedActions.isEmpty) {
      ARLearnAction firstUnsyncedAction = store.state.currentRunState.unsynchronisedActions[0];
      ARLearnAction actionFromServer =
          await ActionsApi.submitAction(firstUnsyncedAction);
      return SyncActionComplete(action: actionFromServer);
    }
    return SyncActionComplete(action: null); // no more actions to post to server
  }));
}



Stream<dynamic> _loadPublicRun(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is LoadPublicRunRequestAction)
      .asyncExpand((action) {
    return yieldLinkExpandRun(action.runId);

  });
}

Stream<dynamic> yieldLinkExpandRun(int runId) async* {
  dynamic runwithgame = await RunsApi.runWithGame(runId);
  if (runwithgame != null && runwithgame['game'] != null) {
    Game game = Game.fromJson(runwithgame['game']);
    print('game titel ${game.title}');
    yield new LoadGameSuccess(game: game); //todo check if ok?
    yield new LoadOneFeaturedRunAction(run: Run.fromJson(runwithgame));
    yield ApiRunsParticipateAction(game.gameId);
  } else {
    yield SetPage(page: PageType.error);
    yield ApiResultError(error: ApiResultError.RUNDOESNOTEXIST, message: '');
    print('what went wrong ${runwithgame}'); //todo
  }
}