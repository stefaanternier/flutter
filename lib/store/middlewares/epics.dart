import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/store/middlewares/all_games.middleware.dart';
import 'package:youplay/store/middlewares/auth.anonymous.middleware.dart';
import 'package:youplay/store/middlewares/auth.custom.middleware.dart';
import 'package:youplay/store/middlewares/auth.google.middleware.dart';
import 'package:youplay/store/middlewares/current_game.actions.middleware.dart';
import 'package:youplay/store/middlewares/current_run.action.middleware.dart';
import 'package:youplay/store/middlewares/current_run.middleware.dart';
import 'package:youplay/store/middlewares/current_run.sync.middleware.dart';
import 'package:youplay/store/middlewares/current_run.upload.middleware.dart';
import 'package:youplay/store/middlewares/game_library.middleware.dart';
import 'package:youplay/store/middlewares/game_messages.middleware.dart';
import 'package:youplay/store/middlewares/game_theme.middleware.dart';
import 'package:youplay/store/middlewares/gameid_to_runs.middleware.dart';
import 'package:youplay/store/middlewares/locations.middleware.dart';
import 'package:youplay/store/middlewares/ui.middleware.dart';
import 'package:youplay/store/state/app_state.dart';

final epic = combineEpics<AppState>([
  runsParticipateEpic,
  currentGameEpic,

  authLoginGoogleEpic,
  loadGoogleCredentials,
  authLoginAppleEpic,
  authLoginAnonymousCredentialsEpic,
  authLoginCustomCredentialsEpic,
  createAccountEpic,
  resetPasswordEpic,
  // googleLoginSucceededEpic,
//  reLoginepic,
  authLogoutEpic,
  authReloginEpic,
  loadAppleCredentials,
  // qrActions,
  // addMeToRun,
//  listGameContent,
//  syncGameContent,
//  syncGameFile,
  uiEpics,
//  gameParticipateEpicNew
  allGameEpics,
  gameMessagesEpics,
  uploadResponseFilesEpic,
  currentRunEpic,
  uploadActionEpic,
  loadPublicRunEpic,
  downloadResponsesForRunEpic,
  downloadActionsForRunEpic,
  deleteResponseForRunEpic,
  gameLibraryEpics,
  testEpoic,
  gameThemeEpics,
  locationEpic,
  deleteRunEpic
]);

var epicMiddleware = new EpicMiddleware(epic);
