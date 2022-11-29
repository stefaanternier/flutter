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


class LoadGameFromOrganisationRequest {
  String organisationId;
  LoadGameFromOrganisationRequest({required this.organisationId});

  @override
  bool operator ==(dynamic other) {
    LoadGameFromOrganisationRequest o = other as LoadGameFromOrganisationRequest;
    return organisationId == o.organisationId;
  }

  @override
  int get hashCode => organisationId.hashCode;
}

class LoadGameFromRunRequest {
  String runId;
  LoadGameFromRunRequest({required this.runId});

  @override
  bool operator ==(dynamic other) {
    LoadGameFromRunRequest o = other as LoadGameFromRunRequest;
    return runId == o.runId;
  }

  @override
  int get hashCode => runId.hashCode;
}

class LoadGameFromRunUnAuthRequest {
  String runId;
  LoadGameFromRunUnAuthRequest({required this.runId});

  @override
  bool operator ==(dynamic other) {
    LoadGameFromRunUnAuthRequest o = other as LoadGameFromRunUnAuthRequest;
    return runId == o.runId;
  }

  @override
  int get hashCode => runId.hashCode;
}


class LoadGameSuccess {
  final Game game;
  const LoadGameSuccess({required this.game});
}

class LoadGameListSuccess {
  final GameList gameList;
  const LoadGameListSuccess({required this.gameList});
}