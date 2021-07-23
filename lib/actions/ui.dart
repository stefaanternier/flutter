
import 'package:youplay/models/general_item.dart';
//
//class ShowMapViewAction {
//  int gameId;
//  ShowMapViewAction(this.gameId);
//}
//
//class ShowListViewAction {
//  int gameId;
//  ShowListViewAction(this.gameId);
//}
//
//class SetPage {
//  PageType page;
//
//  SetPage(this.page);
//
//  @override
//  bool operator ==(dynamic other) {
//    print ("comparing ");
//    if (other is! SetPage) return false;
//    print ("comparing ${page == other.page}");
//    return page == other.page;
//  }
//}

class GeneralItemTakePicture {
  GeneralItem item;
  GeneralItemTakePicture({required this.item});
}

class GeneralItemCancelDataCollection {

  GeneralItemCancelDataCollection();
}

class SetTheme {
  int theme;

  SetTheme(this.theme);

}
