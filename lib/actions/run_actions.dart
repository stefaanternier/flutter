import 'package:youplay/models/run.dart';


//class SyncOutgoingActions{}

//class SyncIncommingActions{
//
//  String resumptionToken ;
//  int fromTime;
//  List<ARLearnAction> actionsFromServer;
//  int runId;
//
//  SyncIncommingActions({this.resumptionToken="-", this.fromTime, this.actionsFromServer, this.runId});
//}

class SyncActionComplete {
  ARLearnAction action;

  SyncActionComplete({this.action});
}

class LocalAction{
  String action;
  int runId;
  int generalItemId;
  final int timeStamp =  DateTime.now().millisecondsSinceEpoch;
  LocalAction({
    this.action,
    this.runId,
    this.generalItemId
   });

  ARLearnAction getAction() {
    return new ARLearnAction(
        runId: runId,
        action: action,
        generalItemId: generalItemId,
        timestamp: this.timeStamp
    );
  }
}


class StartRunAction extends LocalAction {
  StartRunAction({int runId}) :super(action: "startRun", runId:runId);
}

class ReadItemAction extends LocalAction {
  ReadItemAction({int runId, int generalItemId})
      :super(
          action: "read", runId:runId, generalItemId:generalItemId);
}

class QrScannerAction extends LocalAction {
  QrScannerAction({int runId, int generalItemId, String qrCode})
      :super(
      action: qrCode, runId:runId, generalItemId:generalItemId);
}

class MultipleChoiceAnswerAction extends LocalAction {
  MultipleChoiceAnswerAction({int runId, int generalItemId, String answerId})
      :super(
      action: 'answer_$answerId', runId:runId, generalItemId:generalItemId);
}

class AnswerCorrect extends LocalAction {
  AnswerCorrect({int runId, int generalItemId})
      :super(
      action: 'answer_correct', runId:runId, generalItemId:generalItemId);
}

class AnswerWrong extends LocalAction {
  AnswerWrong({int runId, int generalItemId})
      :super(
      action: 'answer_incorrect', runId:runId, generalItemId:generalItemId);
}

class Complete extends LocalAction {
  Complete({int runId, int generalItemId})
      :super(
      action: 'complete', runId:runId, generalItemId:generalItemId);
}

class LocationAction extends LocalAction {
  LocationAction({double lat, double lng, int radius, int runId})
      :super(
      runId:runId,
      action: "geo:$lat:$lng:$radius");
}
