import 'package:flutter/material.dart';
import 'package:youplay/router/youplay-route-path.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/screens/library/game_from_qr.dart';
import 'package:youplay/screens/pages/create_account_page.dart';
import 'package:youplay/screens/pages/game_landing_page.dart';
import 'package:youplay/screens/pages/game_play_page.dart';
import 'package:youplay/screens/pages/game_runs_overview_page.dart';
import 'package:youplay/screens/pages/login_page.dart';
import 'package:youplay/screens/pages/my_games_list_page.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/ui/pages/collection.page.dart';
import 'package:youplay/ui/pages/game_landing.page.container.dart';
import 'package:youplay/ui/pages/game_play.container.dart';
import 'package:youplay/ui/pages/game_runs.page.dart';
import 'package:youplay/ui/pages/my-games-list.page.dart';

class YouplayRouterDelegate extends RouterDelegate<YouplayRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<YouplayRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  Function(PageType, int?) updatePageType;

  YouplayRoutePath youplayRoutePath;

  YouplayRouterDelegate(
      {required this.youplayRoutePath, required this.updatePageType})
      : navigatorKey = GlobalKey<NavigatorState>();

  YouplayRoutePath get currentConfiguration {
    return youplayRoutePath;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: pages(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        youplayRoutePath = youplayRoutePath.parent;
        this.updatePageType(youplayRoutePath.pageType, youplayRoutePath.pageId);
        notifyListeners();

        return true;
      },
    );
  }

  List<Page<dynamic>> pages() {
    print('page is ${youplayRoutePath.pageType}');
    switch (youplayRoutePath.pageType) {
      case PageType.gameLandingPage:
        return [
          MaterialPage(
            key: ValueKey('Library'),
            child: FeaturedGamesPage(
              authenticated: true,
            ),
          ),
          MaterialPage(
              key: ValueKey('GameLandingPage'),
              child: GameLandingPageContainer(
                  gameId: youplayRoutePath
                      .pageId!) //gameId: _youplayRoutePath.gameId!
              )
        ];
      // return GameLandingPage();
      case PageType.runLandingPage:
        // return RunLandingPage();
        break;

      case PageType.game:
        return [
          MaterialPage(
            key: ValueKey('Library'),
            child: FeaturedGamesPage(
              authenticated: true,
            ),
          ),
          MaterialPage(
              key: ValueKey('GamePlayPage'),
              child: GamePlayContainer() //gameId: _youplayRoutePath.gameId!
              )
        ];
      case PageType.gameItem:
        return [
          MaterialPage(
            key: ValueKey('Library'),
            child: FeaturedGamesPage(
              authenticated: true,
            ),
          ),
          MaterialPage(
              key: ValueKey('GamePlayPage'),
              child: GamePlayContainer() //gameId: _youplayRoutePath.gameId!
              ),
          MaterialPage(
              key: ValueKey('ItemPage'),
              child: GeneralItemScreen() //gameId: _youplayRoutePath.gameId!
              )
        ];
      //
      case PageType.login:
        return [
          MaterialPage(
            key: ValueKey('Login'),
            child: LoginPage(),
          ),
        ];

      case PageType.myGames:
        return [
          MaterialPage(
            key: ValueKey('Library'),
            child: FeaturedGamesPage(
              authenticated: true,
            ),
          ),
          MaterialPage(
              key: ValueKey('MyGamesPage'),
              child: MyGamesListPageNew() //gameId: _youplayRoutePath.gameId!
              )
        ];
      case PageType.gameWithRuns:
        return [
          MaterialPage(
            key: ValueKey('Library'),
            child: FeaturedGamesPage(
              authenticated: true,
            ),
          ),
          MaterialPage(
              key: ValueKey('MyGamesPage'),
              child: MyGamesListPageNew() //gameId: _youplayRoutePath.gameId!
              ),
          MaterialPage(
              key: ValueKey('MyRunsOverviewPage'),
              child: GameRunsPage() //gameId: _youplayRoutePath.gameId!
              ),
        ];
        // return authCheck(GameRunsOverviewPage(), pageModel);
        break;

      case PageType.scanGame:
        return [
          MaterialPage(
            key: ValueKey('Library'),
            child: FeaturedGamesPage(
              authenticated: true,
            ),
          ),
          MaterialPage(
              key: ValueKey('QRScannerPage'), child: GameQRScannerPage())
        ];

      case PageType.featured:
        return [
          MaterialPage(
            key: ValueKey('Library'),
            child: FeaturedGamesPage(
              authenticated: true,
            ),
          )
        ];

      case PageType.featured:
        return [
          MaterialPage(
            key: ValueKey('Library'),
            child: FeaturedGamesPage(
              authenticated: true,
            ),
          )
        ];

      case PageType.makeAccount:
        return [
          MaterialPage(
            key: ValueKey('Library'),
            child: FeaturedGamesPage(
              authenticated: true,
            ),
          ),
          MaterialPage(
            key: ValueKey('Login'),
            child: LoginPage(),
          ),
          MaterialPage(
            key: ValueKey('MakeAccount'),
            child: CreateAccountPage(),
          )
        ];
        // return CreateAccountPage();
//            return buildQRScanner(context);

        break;
    }
    print('page is default ${youplayRoutePath.pageType}');
    return [
      MaterialPage(
        key: ValueKey('Library'),
        child: FeaturedGamesPage(
          authenticated: true,
        ),
      )
    ];
  }

  @override
  Future<void> setNewRoutePath(YouplayRoutePath path) async {
    youplayRoutePath = path;
  }

// void _handleBookTapped(Book book) {
//   // _selectedBook = book;
//   notifyListeners();
// }
}
