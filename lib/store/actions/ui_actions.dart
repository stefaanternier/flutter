import 'package:youplay/models/game.dart';
import 'package:youplay/store/state/ui_state.dart';

class ToggleMessageViewAction {

  int? gameId;
  MessageView? messageView;
  Game game;
  ToggleMessageViewAction({this.gameId, this.messageView, required this.game});
}

class SetMessageViewAction {

  MessageView messageView;
  SetMessageViewAction({required this.messageView});
}



//class ShowMapViewAction {
//  int gameId;
//
//  ShowMapViewAction(this.gameId);
//}
//
//class ShowListViewAction {
//  int gameId;
//
//  ShowListViewAction(this.gameId);
//}

class SetPage {
  PageType page;
  int? pageId;
  int? itemId;

  SetPage({
    required this.page,
    this.pageId,
    this.itemId
  });

  @override
  bool operator == (dynamic other) {
    if (other is! SetPage) return false;
    return page == other.page;
  }
}

class ResetRunsAndGoToLandingPage {

}

class ResetRunsAndGoToRunLandingPage {
  int runId;
  ResetRunsAndGoToRunLandingPage({required this.runId});
}
