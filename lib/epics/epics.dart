import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/store/middlewares/current_run.middleware.dart';
import 'package:youplay/store/middlewares/game_library.middleware.dart';
import 'package:youplay/store/middlewares/game_theme.middleware.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/epics/store_epics.dart';
import 'package:youplay/epics/account_epics.dart';
import 'package:youplay/epics/games.dart';
import 'package:youplay/epics/general_items.dart';
import 'package:youplay/epics/runs.dart';
import 'package:youplay/epics/run_actions.dart';
import 'package:youplay/epics/game_library_qr.dart';

import 'package:youplay/store/middlewares/all_games.middleware.dart';
import 'package:youplay/store/middlewares/auth.anonymous.middleware.dart';
import 'package:youplay/store/middlewares/auth.custom.middleware.dart';
import 'package:youplay/store/middlewares/auth.google.middleware.dart';
import 'package:youplay/store/middlewares/current_game.actions.middleware.dart';
import 'package:youplay/store/middlewares/current_run.action.middleware.dart';
import 'package:youplay/store/middlewares/current_run.sync.middleware.dart';
import 'package:youplay/store/middlewares/current_run.upload.middleware.dart';
import 'package:youplay/store/middlewares/game_messages.middleware.dart';
import 'package:youplay/store/middlewares/ui.middleware.dart';

final epic = combineEpics<AppState>([
//  storeFeaturedGamesEpic,
//  gameParticipateEpic,
  runUsersEpic,
//  gameEpic,
  currentGameEpic,
//  runGameEpic,
//  gameGeneralItemEpic,
  getRunEpic,
  runVisibleItems,
  runsParticipateEpic,
//  syncOutgoingActions,

  gameParticipateResultsEpic,
//  gameParticipateResultsEpic,
//  uploadResponseFilesEpic,
//  accountDetailsEpic,
  authLoginGoogleEpic,
  loadGoogleCredentials,
  // authLoginAppleEpic,
  authLoginAnonymousCredentialsEpic,
//  authLoginTwitterEpic,
//  authLoginFacebookEpic,
   authLoginCustomCredentialsEpic,
  createAccountEpic,
  resetPasswordEpic,
 // googleLoginSucceededEpic,
//  reLoginepic,
  authLogoutEpic,
  authReloginEpic,
  loadAppleCredentials,
  // qrActions,
  addMeToRun,
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
  downloadResponsesForRunEpic,
  downloadActionsForRunEpic,
  deleteResponseForRunEpic,
  gameLibraryEpics,
  testEpoic,
  gameThemeEpics
]);


var epicMiddleware = new EpicMiddleware(epic);

