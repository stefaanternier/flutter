import 'package:flutter/material.dart';
import 'package:youplay/router/youplay-route-path.dart';
import 'package:youplay/store/state/ui_state.dart';

class BookRouteInformationParser
    extends RouteInformationParser<YouplayRoutePath> {

  Function(PageType, int?) updatePageType;

  BookRouteInformationParser({required this.updatePageType});

  @override
  Future<YouplayRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return YouplayRoutePath.home();
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'login') {
        return YouplayRoutePath(pageType: PageType.login);
      }
      if (uri.pathSegments[0] == 'featured') {
        return YouplayRoutePath(pageType: PageType.featured);
      }
      if (uri.pathSegments[0] == 'myGames') {
        return YouplayRoutePath(pageType: PageType.myGames);
      }
      if (uri.pathSegments[0] == 'scan') {
        return YouplayRoutePath(pageType: PageType.scanGame);
      }
      return YouplayRoutePath.home();
    }
    // Handle '/game/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == 'game') {
        var remaining = uri.pathSegments[1];
        var id = int.tryParse(remaining);
        if (id == null) return YouplayRoutePath.unknown();
        this.updatePageType(PageType.gameLandingPage, id);
        return YouplayRoutePath(pageType: PageType.gameLandingPage, pageId: id);
      }

      if (uri.pathSegments[0] == 'run') {
        var remaining = uri.pathSegments[1];
        var id = int.tryParse(remaining);
        if (id == null) return YouplayRoutePath.unknown();
        return YouplayRoutePath(pageType: PageType.game, pageId: id);
      }
    }
    if (uri.pathSegments.length == 4) {
      if (uri.pathSegments[0] == 'run' && uri.pathSegments[2] == 'item') {
        var run = uri.pathSegments[1];
        var runId = int.tryParse(run);
        var item = uri.pathSegments[3];
        var itemId = int.tryParse(item);
        if (runId == null || itemId == null) return YouplayRoutePath.unknown();
        return YouplayRoutePath(
            pageType: PageType.gameItem, pageId: runId, itemId: itemId);
      }
    }

    // Handle unknown routes
    return YouplayRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(YouplayRoutePath path) {
    print('restore path ${path.pageId}');
    switch (path.pageType) {
      case PageType.gameLandingPage:
        return RouteInformation(location: '/game/${path.pageId}');
      case PageType.game:
        return RouteInformation(location: '/run/${path.pageId}');
//              return GameScreen(false);
//         return authCheck(GamePlayPage(), pageModel);
        break;
      // case PageType.gameMapView:
      //   return RouteInformation(location: '/run_map/${path.pageId}');
      // case PageType.gameBoardView:
      //   return RouteInformation(location: '/run_board/${path.pageId}');
      case PageType.gameItem:
        return RouteInformation(
            location: '/run/${path.pageId}/item/${path.itemId}');
      case PageType.login:
        return RouteInformation(location: '/login');
      case PageType.featured:
        return RouteInformation(location: '/featured');
      case PageType.myGames:
        return RouteInformation(location: '/myGames');
      case PageType.scanGame:
        return RouteInformation(location: '/scan');
      case PageType.runLandingPage:
        // return RunLandingPage();
        break;
      case PageType.gameWithRuns:
        // return authCheck(GameRunsOverviewPage(), pageModel);
        break;

      // case PageType.gameStartWithMap:
      //   // return authCheck(GamePlayPage(), pageModel);
      //   break;

//       case PageType.library:
//         // return FeaturedGamesPage(authenticated: pageModel.isAuthenticated);
// //              return buildFeaturedGamesOnly(context);
//
//         break;


      case PageType.makeAccount:
        return RouteInformation(location: '/makeaccount');
    }
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    // if (path.isDetailsPage) {
    //   return RouteInformation(location: '/book/${path.id}');
    // }
    return RouteInformation(location: '/');
  }
}
