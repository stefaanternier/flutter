import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/game_messages.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_library.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

class RunLandingPageViewModel {
  bool isAuth;
  Run? run;
  int amountOfRuns;
  List<Run> runs;
  Game? game;
  GameTheme? gameTheme;
  // Store store;
  Function loadRuns;
  Function joinRun;
  Function toRunPage;

  RunLandingPageViewModel({
    this.run,
    required this.runs,
    required this.amountOfRuns,
    this.game,
    this.gameTheme,
    required this.isAuth,
    required this.loadRuns,
    required this.toRunPage,
    required this.joinRun});

  static RunLandingPageViewModel fromStore(Store<AppState> store,
      BuildContext context) {
    Game? copyGame = gameSelector(store.state.currentGameState);
    Run? copyRun = featuredRunSelector(store.state);
    return RunLandingPageViewModel(
        // store: store,
        run: featuredRunSelector(store.state),
        runs: currentRunsSelector(store.state),
        game: gameSelector(store.state.currentGameState),
        amountOfRuns: amountOfRunsSelector(store.state.currentGameState),
        gameTheme: gameThemeSelector(store.state.currentGameState),
        isAuth: isAuthenticatedSelector(store.state),
        loadRuns: () {
          if (copyGame != null) {
            store.dispatch(ApiRunsParticipateAction(copyGame.gameId));
          }
        },
        joinRun: () {
          if (copyRun != null) {
            store.dispatch(RegisterToRunAction(run: copyRun));
          }
        },
        toRunPage: () {
          if (copyRun != null) {
            store.dispatch(SetCurrentRunAction(run: copyRun));
            if (copyRun.runId != null) {
              store.dispatch(new ApiRunsVisibleItems(copyRun.runId!));
              store.dispatch(new StartRunAction(runId: copyRun.runId!));
              store.dispatch(new SyncResponsesServerToMobile(
                  runId: copyRun.runId!,
                  from: 1,
                  till: new DateTime.now().millisecondsSinceEpoch));
              store.dispatch(
                  new SyncActionsServerToMobile(runId: copyRun.runId!, from: 1));
            }
          }
          store.dispatch(new LoadGameMessagesListRequestAction());
          store.dispatch(SetPage(page: PageType.game));
        }
    );
  }


}
