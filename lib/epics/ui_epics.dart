import 'dart:collection';

import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'package:redux_epics/redux_epics.dart';

import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/actions/all_games.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';

//final pageLoaded = new TypedEpic<AppState, SetPage>(_loadPageEpic);
//
//
//Stream<dynamic> _loadPageEpic(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions
//      .where((action) => action is SetPage)
//      .asyncMap((action) {
//          switch (action.page) {
//
//            case PageType.myGames:
////              return ApiGamesParticipateAction();
//              if (store.state.authentication.idToken != null){
//                return LoadParticipateGamesListRequestAction();
//              } else {
//                return new SetPage(PageType.login);
//              }
//
//              break;
//
//            case PageType.featured:
////              print ("executing init actions for featured once");
//
//
//              break;
//            case PageType.game:
//              break;
//            case PageType.gameStartWithMap:
//              break;
//
//            case PageType.gameWithRuns:
//              break;
//            case PageType.library:
//            case PageType.scanGame:
//              break;
//          }
//
//
//  } );
//}
