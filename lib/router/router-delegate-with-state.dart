import 'package:flutter/material.dart';
import 'package:youplay/router/youplay-route-path.dart';
import 'package:youplay/screens/library/game_from_qr.dart';
import 'package:youplay/screens/pages/create_account_page.dart';
import 'package:youplay/screens/pages/login_page.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/ui/pages/collection.page.dart';
import 'package:youplay/ui/pages/game_landing.page.container.dart';
import 'package:youplay/ui/pages/game_play.container.dart';
import 'package:youplay/ui/pages/game_runs.page.dart';
import 'package:youplay/ui/pages/intro-page.container.dart';
import 'package:youplay/ui/pages/login_page.container.dart';
import 'package:youplay/ui/pages/message.page.container.dart';
import 'package:youplay/ui/pages/my-games-list.page.dart';
import 'package:youplay/ui/pages/run_landing.page.container.dart';
import 'package:youplay/ui/pages/splashscreen.container.dart';

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
      observers: [HeroController()],
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
    switch (youplayRoutePath.pageType) {
      case PageType.intro:
        return [
          MaterialPage(
              key: ValueKey('Splash'),
              child: SplashScreenContainer(
                finished: (){
                  youplayRoutePath.pageType = PageType.introAfterSplash;
                  print('to intro after splash');
                  notifyListeners();
                },
              ) //gameId: _youplayRoutePath.gameId!
          )
        ];

      case PageType.introAfterSplash:
        return [
          MaterialPage(
              key: ValueKey('Intro'),
              child: IntroPageContainer()
          )
        ];

    case PageType.splash:
        return [
          MaterialPage(
              key: ValueKey('Splash'),
              child: SplashScreenContainer(
                finished: (){
                  youplayRoutePath.pageType = PageType.featured;
                  notifyListeners();
                },
              ) //gameId: _youplayRoutePath.gameId!
          )
        ];
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
        print('rendering rlp');
        return [
          MaterialPage(

            key: ValueKey('Library'),
            child: FeaturedGamesPage(
              authenticated: true,
            ),
          ),
          MaterialPage(
              key: ValueKey('RunLandingPage'),
              child: RunLandingPageContainer(
                  runId: youplayRoutePath
                      .pageId!) //gameId: _youplayRoutePath.gameId!
          )
        ];
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
          // MaterialPage(
          //     key: ValueKey('ItemPage'),
          //     child: GeneralItemScreen() //gameId: _youplayRoutePath.gameId!
          //     ),
          MaterialPage(
              key: ValueKey('ItemPage'),
              child: MessagePageContainer() //gameId: _youplayRoutePath.gameId!
          )
        ];
      //
      case PageType.login:
        return [
          MaterialPage(
            key: ValueKey('Login'),
            child: LoginPageContainer(), //LoginPage(),
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
              child: GameRunsPage(init: (){}) //gameId: _youplayRoutePath.gameId!
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
          TransitionWithDurationPage(
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

}


class TransitionWithDurationPage extends Page {
  final Widget child;

  TransitionWithDurationPage({required this.child, LocalKey? key}) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: Duration(milliseconds: 750),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}