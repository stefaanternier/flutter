import 'package:youplay/state/ui_state.dart';

class ToggleMessageViewAction {

  int gameId;
  MessageView? messageView;
  ToggleMessageViewAction({required this.gameId, this.messageView});
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

  SetPage(this.page);

  @override
  bool operator ==(dynamic other) {
    print("comparing ");
    if (other is! SetPage) return false;
    print("comparing ${page == other.page}");
    return page == other.page;
  }
}

class ResetRunsAndGoToLandingPage {

}

class ResetRunsAndGoToRunLandingPage {

}
