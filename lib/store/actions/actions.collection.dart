import 'package:youplay/models/game.dart';

class CollectionReset {

}

class LoadPublicGameRequest {
  int gameId;
  LoadPublicGameRequest({required this.gameId});

  @override
  bool operator ==(dynamic other) {
    LoadPublicGameRequest o = other as LoadPublicGameRequest;
    return gameId == o.gameId;
  }

  @override
  int get hashCode => gameId.hashCode;
}

class LoadPublicGameSuccess {
  Game game;
  LoadPublicGameSuccess({required this.game});
}

class LoadRecentGameRequest {
  LoadRecentGameRequest();

  @override
  bool operator ==(dynamic other) => true;

  @override
  int get hashCode => 1;
}

class LoadRecentGamesSuccess {
  GameList gameList;
  LoadRecentGamesSuccess({required this.gameList});

  @override
  bool operator ==(dynamic other) {
    LoadRecentGamesSuccess o = other as LoadRecentGamesSuccess;
    return gameList.resumptionToken == o.gameList.resumptionToken;
  }

  @override
  int get hashCode => gameList.resumptionToken.hashCode;
}

class LoadFeaturedGameRequest {
  LoadFeaturedGameRequest();

  @override
  bool operator ==(dynamic other) => true;

  @override
  int get hashCode => 1;
}


class LoadFeaturedGameSuccess {
  GameList gameList;
  LoadFeaturedGameSuccess({required this.gameList});

  @override
  bool operator ==(dynamic other) {
    LoadFeaturedGameSuccess o = other as LoadFeaturedGameSuccess;
    return gameList.resumptionToken == o.gameList.resumptionToken;
  }

  @override
  int get hashCode => gameList.resumptionToken.hashCode;
}


class ParseLinkAction {
  final String link;

  ParseLinkAction({required this.link});

  get gameId {
    String gameId = link.substring(link.indexOf('game') + 5);
    if (link.contains('gameId')) {
      gameId = link.substring(link.indexOf('gameId') + 7);
    }
    return int.parse(gameId);
  }

  get runId {
    String _runId = link.substring(link.indexOf('run') + 4);
    if (link.contains('runId')) {
      _runId = link.substring(link.indexOf('runId') + 6);
    }
    return int.parse(_runId);
  }

  bool isGameLink() => link.indexOf('game') != -1 || link.indexOf('gameId') != -1;
  bool isRunLink() => link.indexOf('run') != -1 || link.indexOf('runId') != -1;
}