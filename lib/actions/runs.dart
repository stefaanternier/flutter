
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';




//class GenericResponseMetadataAction {
//  Response response;
//
//  GenericResponseMetadataAction({this.response});
//}
//
//class SyncFileResponse{
//  int runId;
//
//  SyncFileResponse({this.runId});
//}

class ApiRunsParticipateAction{
  int gameId;

  ApiRunsParticipateAction(this.gameId);
}

class ApiResultRunsParticipateAction {
  List<Run> runs;
  int gameId;

  ApiResultRunsParticipateAction({required this.runs, required  this.gameId});
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


class ApiLoadRunAction{
  int runId;
  ApiLoadRunAction(this.runId);
}


class ApiResultLoadRunAction {
  dynamic run;
  int runId;
  ApiResultLoadRunAction(this.runId, this.run);
}
