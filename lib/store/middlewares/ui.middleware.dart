
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/store/actions/all_games.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';

final uiEpics = combineEpics<AppState>([
  new TypedEpic<AppState, SetPage>(_loadPageEpic),
  // new TypedEpic<AppState, ResetRunsAndGoToLandingPage>(_resetAndToLandingPage),
  new TypedEpic<AppState, ResetRunsAndGoToRunLandingPage>(_resetAndToRunLandingPage)
]);

Stream<dynamic> _loadPageEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is SetPage)
      .where((action) => action.page == PageType.myGames)
      .asyncMap((action) {
    if (store.state.authentication.authenticated) {
      return LoadParticipateGamesListRequestAction();
    }
    return new SetPage(page: PageType.login);
  });
}

// Stream<dynamic> _resetAndToLandingPage(Stream<dynamic> actions, EpicStore<AppState> store) {
//   return actions
//       .where((action) => action is ResetRunsAndGoToLandingPage)
//       .asyncMap((action) {
//
//     return new SetPage(page: PageType.gameLandingPage);
//   });
// }

Stream<dynamic> _resetAndToRunLandingPage(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is ResetRunsAndGoToRunLandingPage)
      .asyncMap((action) {

    return new SetPage(page: PageType.runLandingPage, pageId: action.runId);
  });
}

