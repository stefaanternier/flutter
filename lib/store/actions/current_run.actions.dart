
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/state/run_state.dart';


class RegisterToRunAction {
  Run run;

//  RunState runState;
  RegisterToRunAction({this.run});
}

class SetCurrentRunAction {
  Run run;

//  RunState runState;
  SetCurrentRunAction({this.run});
}

class RequestNewRunAction {
  int gameId;
  String name;

  RequestNewRunAction({this.gameId, this.name = 'demo run'});
}


class SyncFileResponse{
  int runId;

  SyncFileResponse({this.runId});
}

class SyncFileResponseComplete{
  int runId;
  Response responseFromServer;

  SyncFileResponseComplete({this.runId, this.responseFromServer});
}

//class PostResponseMetadata {
//  Response response;
//
//  PostResponseMetadata({this.response});
//}

class SyncResponsesServerToMobile{
  int runId;
  int generalItemId;
  String resumptionToken;
  int from;
  int till;

  SyncResponsesServerToMobile({
    this.runId,
    this.generalItemId = null,
    this.from = null,
    this.till = null,
    this.resumptionToken = "*"});
}

class SyncResponsesServerToMobileComplete{
  ResponseList result;

  SyncResponsesServerToMobileComplete({this.result});
}


class SyncActionsServerToMobile{
  int runId;
  String resumptionToken;
  int from;

  SyncActionsServerToMobile({this.runId, this.from, this.resumptionToken = "*"});
}

class SyncActionsServerToMobileComplete{
  ARLearnActionsList result;

  SyncActionsServerToMobileComplete({this.result});
}

//class SyncARLearnActionsServerToMobile{
//  int runId;
//  String resumptionToken;
//  int from;
//
//  SyncARLearnActionsServerToMobile({this.runId, this.from, this.resumptionToken = "-"});
//}

class SyncARLearnActionsListServerToMobileComplete{
  ARLearnActionsList result;

  SyncARLearnActionsListServerToMobileComplete({this.result});
}

class DeleteResponseFromServer {
  int responseId;

  DeleteResponseFromServer({this.responseId});
}

class DeleteResponseFromLocalStore {
  int responseId;

  DeleteResponseFromLocalStore({this.responseId});
}
