

import 'package:youplay/models/general_item.dart';

class LoadGameMessagesRequest {
  String gameId;
  LoadGameMessagesRequest({required this.gameId});

  @override
  bool operator ==(dynamic other) {
    LoadGameMessagesRequest o = other as LoadGameMessagesRequest;
    return gameId == o.gameId;
  }

  @override
  int get hashCode => gameId.hashCode;
}


class LoadMessageListSuccess {
  GeneralItemList itemsList;
  LoadMessageListSuccess({required this.itemsList});
}