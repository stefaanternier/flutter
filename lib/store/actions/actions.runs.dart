


import 'package:youplay/models/run.dart';

class LoadRunRequest {
  int runId;
  LoadRunRequest({required this.runId});

  @override
  bool operator ==(dynamic other) {
    LoadRunRequest o = other as LoadRunRequest;
    return runId == o.runId;
  }

  @override
  int get hashCode => runId.hashCode;
}

class LoadRunAuthRequest {
  int runId;
  LoadRunAuthRequest({required this.runId});

  @override
  bool operator ==(dynamic other) {
    LoadRunAuthRequest o = other as LoadRunAuthRequest;
    return runId == o.runId;
  }

  @override
  int get hashCode => runId.hashCode;
}


class LoadRunSuccess {
  Run run;
  LoadRunSuccess({required this.run});
}

class LoadRunListSuccess {
  RunList runList;
  LoadRunListSuccess({required this.runList});
}


class DeleteRunAction {
  Run run;

  DeleteRunAction({required this.run});
}

class LoadGameRunsRequest {
  int gameId;
  LoadGameRunsRequest({required this.gameId});

  @override
  bool operator ==(dynamic other) {
    LoadGameRunsRequest o = other as LoadGameRunsRequest;
    return gameId == o.gameId;
  }

  @override
  int get hashCode => gameId.hashCode;
}


