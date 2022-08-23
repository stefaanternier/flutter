


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


class LoadRunSuccess {
  Run run;
  LoadRunSuccess({required this.run});
}

class LoadRunListSuccess {
  RunList runList;
  LoadRunListSuccess({required this.runList});
}