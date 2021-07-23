import 'package:youplay/screens/library/game_from_qr.dart';
import 'package:youplay/screens/pages/create_account_page.dart';
import 'package:youplay/screens/pages/game_landing_page.dart';
import 'package:youplay/screens/pages/game_play_page.dart';
import 'package:youplay/screens/pages/game_runs_overview_page.dart';
import 'package:youplay/screens/pages/run_landing_page.dart';
import 'package:youplay/screens/ui_models/selected_page_model.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/store/state/app_state.dart';

import '../debug/debug_participate_gameids.dart';
import 'featured_games_page.dart';
import 'login_page.dart';
import 'my_games_list_page.dart';

class HomeViewModel {
  PageType selectedPage;

  HomeViewModel({required this.selectedPage});
}

class SplashScreen extends StatelessWidget {
  SplashScreen();

  Widget authCheck(Widget authenticatedWidget, SelectedPageModel selectedPageModel) {
    if (selectedPageModel.isAuthenticated) {
      return authenticatedWidget;
    }
    return LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SelectedPageModel>(
        distinct: true,
        converter: (store) => SelectedPageModel.fromStore(store),
        builder: (context, pageModel) {
          switch (pageModel.selectedPage) {
            case PageType.gameLandingPage:
              return GameLandingPage();
                  break;
            case PageType.runLandingPage:
              return RunLandingPage();
              break;
            case PageType.gameWithRuns:
              return authCheck(GameRunsOverviewPage(), pageModel);
              break;
            case PageType.game:
//              return GameScreen(false);
              return authCheck(GamePlayPage(), pageModel);
              break;
            // case PageType.gameStartWithMap:
            //   return authCheck(GamePlayPage(), pageModel);
            //   break;

            case PageType.myGames:
              return authCheck(MyGamesListPage(), pageModel);
              break;

            case PageType.featured:
              return FeaturedGamesPage(authenticated: pageModel.isAuthenticated);
//              return buildFeaturedGamesOnly(context);
              break;

//             case PageType.library:
//               return FeaturedGamesPage(authenticated: pageModel.isAuthenticated);
// //              return buildFeaturedGamesOnly(context);
//
//               break;
            case PageType.scanGame:
              // return buildQRScanner(context);

            //return buildFeaturedGamesOnly(context);
            case PageType.login:
              return LoginPage();
//            return buildQRScanner(context);
              break;
            case PageType.makeAccount:
              return CreateAccountPage();
//            return buildQRScanner(context);
              break;

          }
          return LoginPage();
        });
  }
}
