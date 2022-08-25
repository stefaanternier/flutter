import 'package:youplay/models/game.dart';
import 'package:youplay/store/state/ui_state.dart';

class ToggleMessageViewAction {

  int? gameId;
  MessageView? messageView;
  Game game;
  ToggleMessageViewAction({this.gameId, this.messageView, required this.game});
}

class SetMessageViewAction {

  int messageView;
  SetMessageViewAction({required this.messageView});
}

class SetCurrentGeneralItemId {
  int itemId;

  SetCurrentGeneralItemId(this.itemId);
}

class SetPage {
  PageType page;
  int? gameId;
  int? runId;
  int? pageId;
  int? itemId;

  SetPage({
    required this.page,
    this.pageId,
    this.gameId,
    this.runId,
    this.itemId
  });

  @override
  bool operator == (dynamic other) {
    if (other is! SetPage) return false;
    return page == other.page;
  }
}


// class ResetRunsAndGoToRunLandingPage {
//   int runId;
//   ResetRunsAndGoToRunLandingPage({required this.runId});
// }
