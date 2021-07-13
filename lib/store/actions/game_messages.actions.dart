import 'package:youplay/models/general_item.dart';

import 'actions.dart';

class LoadGameMessagesListRequestAction {
  LoadGameMessagesListRequestAction();
}

class LoadGameMessagesListResponseAction extends GenericWebResponseAction {


  LoadGameMessagesListResponseAction({resultAsString}) : super(resultAsString: resultAsString);


  String? getCursor() {
    return getResultsAsJson()['resumptionToken'];
  }

  List<GeneralItem> getGeneralItemList(int retainGameId) {
    if (getResultsAsJson()['generalItems'] == null) {
      print("error, no general items");
      return [];
    }

    return (getResultsAsJson()['generalItems'] as List)
        .map((dynamicItem) => GeneralItem.fromJson(dynamicItem))
        .where((item) => item.gameId == retainGameId)
        .toList();
  }
}
