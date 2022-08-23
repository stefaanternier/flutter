import 'package:youplay/models/game.dart';

class LoadGameRequest {
  String gameId;
  LoadGameRequest({required this.gameId});

  @override
  bool operator ==(dynamic other) {
    LoadGameRequest o = other as LoadGameRequest;
    return gameId == o.gameId;
  }

  @override
  int get hashCode => gameId.hashCode;
}


class LoadGameSuccess {
  Game game;
  LoadGameSuccess({required this.game});
}
