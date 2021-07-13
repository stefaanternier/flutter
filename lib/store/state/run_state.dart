import 'dart:collection';

import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/models/response.dart';

class RunState {
  Run? run;
  int lastSync = 10;
  HashMap<String, ARLearnAction> actionsFromServer = new HashMap();
  HashMap<int, Response> responsesFromServer = new HashMap();
  List<ARLearnAction> unsynchronisedActions = [];

  List<int> deleteList = [];

  HashMap<int, GeneralItemsVisibility> itemVisibilityFromServer = new HashMap();
  HashMap<int, GeneralItemsVisibility> itemInVisibilityFromServer =
      new HashMap();

  dynamic messages;
  int lastActionModification = 0;

  List<PictureResponse> outgoingPictureResponses = []; //remove this
  List<Response> outgoingResponses = [];

  RunState({this.run});

  RunState.fromRunState(RunState runState)
      : run = runState.run,
        lastSync = runState.lastSync,
        actionsFromServer = runState.actionsFromServer ,
        responsesFromServer = runState.responsesFromServer ,
        unsynchronisedActions = runState.unsynchronisedActions ,
        messages = runState.messages,
        outgoingPictureResponses = runState.outgoingPictureResponses ,
        outgoingResponses = runState.outgoingResponses ,
        itemVisibilityFromServer =
            runState.itemVisibilityFromServer ,
        itemInVisibilityFromServer =
            runState.itemInVisibilityFromServer;

  RunState copyWith({run, l, a, respFromServer, u, m, op, or, it, reset, toDeleteItem}) {
    RunState r = new RunState(run: run ?? this.run);
    r.lastSync = l ?? this.lastSync;
    r.actionsFromServer = a ?? this.actionsFromServer;
    r.responsesFromServer = responsesFromServer ;
    r.unsynchronisedActions = u ?? this.unsynchronisedActions;
    r.messages = m ?? this.messages;
    r.outgoingPictureResponses = op ?? this.outgoingPictureResponses;
    r.outgoingResponses = or ?? this.outgoingResponses;
    r.itemVisibilityFromServer = it ?? this.itemVisibilityFromServer;
    r.lastActionModification = (reset != null && reset)
        ? new DateTime.now().millisecondsSinceEpoch
        : r.lastActionModification;
    r.deleteList = (toDeleteItem!= null)? [...this.deleteList, toDeleteItem] : this.deleteList;
    return r;
  }

  RunState.fromJson(Map json) : run = Run.fromJson(json["run"]);

  dynamic toJson() => {
        'run': run?.toJson()?? {},
      };
}
