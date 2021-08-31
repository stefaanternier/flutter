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
  HashMap<int, GeneralItemsVisibility> itemInVisibilityFromServer = new HashMap();

  // dynamic messages;
  int lastActionModification = 0;

  List<PictureResponse> outgoingPictureResponses = []; //remove this
  List<Response> outgoingResponses = [];

  bool syncingActionsFromServer;

  static RunState init() => RunState(
        syncingActionsFromServer: false,
        outgoingResponses: [],
        outgoingPictureResponses: [],
        lastActionModification: 0,
        itemVisibilityFromServer: new HashMap(),
        itemInVisibilityFromServer: new HashMap(),
        deleteList: [],
        unsynchronisedActions: [],
        responsesFromServer: new HashMap(),
        actionsFromServer: new HashMap(),
        lastSync: 10
      );

  RunState({
    this.run,
    this.syncingActionsFromServer = false,
    required this.lastSync,
    required this.actionsFromServer,
    required this.responsesFromServer,
    required this.unsynchronisedActions,
    // required this.messages,
    required this.outgoingPictureResponses,
    required this.outgoingResponses,
    required this.itemVisibilityFromServer,
    required this.itemInVisibilityFromServer,
    required this.lastActionModification,
    required this.deleteList,
  });

  RunState copyWith({run, l, a, respFromServer, u, op, or, it, itInV, reset, toDeleteItem, isSyncingActions}) {
    return new RunState(
        run: run ?? this.run,
        syncingActionsFromServer: isSyncingActions ?? this.syncingActionsFromServer,
        lastSync: l ?? this.lastSync,
        actionsFromServer: a ?? this.actionsFromServer,
        responsesFromServer: respFromServer ?? this.responsesFromServer,
        unsynchronisedActions: u ?? this.unsynchronisedActions,
        // messages: m ?? this.messages,
        outgoingPictureResponses: op ?? this.outgoingPictureResponses,
        outgoingResponses: or ?? this.outgoingResponses,
        itemVisibilityFromServer: it ?? this.itemVisibilityFromServer,
        itemInVisibilityFromServer: itInV ?? this.itemInVisibilityFromServer,
        deleteList: (toDeleteItem != null) ? [...this.deleteList, toDeleteItem] : this.deleteList,
        lastActionModification:
            (reset != null && reset) ? new DateTime.now().millisecondsSinceEpoch : this.lastActionModification);
  }

  RunState.fromJson(Map json)
      : run = Run.fromJson(json["run"]),
        syncingActionsFromServer = false;

  dynamic toJson() => {
        'run': run?.toJson() ?? {},
      };
}
