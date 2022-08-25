
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';

class LoadPublicRunRequestAction {
  final int runId;
  const LoadPublicRunRequestAction({required this.runId});
}

class RegisterToRunAction {
  Run run;

//  RunState runState;
  RegisterToRunAction({required this.run});
}



class SetCurrentRunAction {
  Run run;
  SetCurrentRunAction({required this.run});
}

class RequestNewRunAction {
  int gameId;
  String name;

  RequestNewRunAction({required this.gameId, required this.name }); //= 'demo run'
}


class SyncFileResponse{
  int runId;

  SyncFileResponse({required this.runId});
}

class SyncFileResponseComplete{
  int runId;
  Response responseFromServer;

  SyncFileResponseComplete({required this.runId, required this.responseFromServer});
}

//class PostResponseMetadata {
//  Response response;
//
//  PostResponseMetadata({this.response});
//}

class SyncResponsesServerToMobile{
  int runId;
  int? generalItemId;
  String resumptionToken;
  int? from;
  int? till;

  SyncResponsesServerToMobile({
    required this.runId,
    this.generalItemId ,
    this.from ,
    this.till ,
    this.resumptionToken = "*"});
}

class SyncResponsesServerToMobileComplete{
  ResponseList result;

  SyncResponsesServerToMobileComplete({required this.result});
}


class SyncActionsServerToMobile{
  int runId;
  String resumptionToken;
  int from;

  SyncActionsServerToMobile({required  this.runId,required  this.from, this.resumptionToken = "*"});
}

class SyncActionsServerToMobileComplete{
  ARLearnActionsList result;

  SyncActionsServerToMobileComplete({required this.result});
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
  bool isLast;

  SyncARLearnActionsListServerToMobileComplete({required this.result, required this.isLast});
}

class DeleteResponseFromServer {
  int responseId;

  DeleteResponseFromServer({required this.responseId});
}

class DeleteResponseFromLocalStore {
  int responseId;

  DeleteResponseFromLocalStore({required  this.responseId});
}

class SyncActionComplete {
  ARLearnAction? action;

  SyncActionComplete({this.action});
}

class ApiRunsVisibleItems{
  int runId;
  ApiRunsVisibleItems(this.runId);

}
class ApiResultRunsVisibleItems {
  dynamic visibleItems;
  int runId;

  ApiResultRunsVisibleItems(this.visibleItems, this.runId);
}