
import 'package:youplay/store/state/ui_state.dart';

class YouplayRoutePath {

  PageType pageType;
  int? pageId;
  int? gameId;
  int? runId;
  int? itemId;

  bool isUnknown;

  YouplayRoutePath({required this.pageType,
    this.pageId,
    this.gameId,
    this.runId,
    this.itemId,
    this.isUnknown = false});

  YouplayRoutePath.pageType({required this.pageType})
      : isUnknown = false;

  YouplayRoutePath.home()
      : pageType = PageType.splash,
        isUnknown = false;

  YouplayRoutePath.intro()
      : pageType = PageType.intro,
        isUnknown = false;

  YouplayRoutePath.game({
    required this.pageId}) :
        isUnknown = false,
        pageType = PageType.gameLandingPage;

  YouplayRoutePath.unknown()
      : pageType = PageType.featured,
        isUnknown = true;

  bool get isHomePage => pageType == PageType.featured;

  bool get isGamePage => pageType == PageType.gameLandingPage && pageId != null;

  YouplayRoutePath get parent {
    if (pageType == PageType.gameItem){
      return YouplayRoutePath(pageType: PageType.game, pageId: pageId, gameId: gameId);
    }
    print("set paht to home via parent $gameId");
    return YouplayRoutePath.home();
  }

}