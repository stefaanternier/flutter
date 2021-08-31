import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/api/actions.dart';
import 'package:youplay/api/response.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/state/app_state.dart';

final downloadResponsesForRunEpic =
    new TypedEpic<AppState, SyncResponsesServerToMobile>(_downloadResponses);

final downloadActionsForRunEpic =
    new TypedEpic<AppState, SyncActionsServerToMobile>(_downloadActions);

final deleteResponseForRunEpic =
    new TypedEpic<AppState, DeleteResponseFromServer>(_deleteResponse);

Stream<dynamic> _downloadResponses(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is SyncResponsesServerToMobile)
      .asyncExpand((action) {
    if ((action as SyncResponsesServerToMobile).generalItemId != null &&
        action.generalItemId != null) {
      return yieldResumeAction(
          action,
          ResponseApi.getResponseForMe(action.runId, action.generalItemId!)
              .then((ResponseList list) {
            return list;
          }));
    }
    return yieldResumeAction(
        action,
        ResponseApi.getResponse(
                action.runId,
                action.from ?? 1,
                action.till ?? DateTime.now().millisecondsSinceEpoch,
                action.resumptionToken)
            .then((ResponseList list) {
          return list;
        }));
  });
}

Stream<dynamic> yieldResumeAction(
    action, Future<ResponseList> futureList) async* {
  ResponseList list = await futureList;
  if (list.resumptionToken != null) {
    (action as SyncResponsesServerToMobile).resumptionToken =
        list.resumptionToken!;
    yield action;
  }
  yield new SyncResponsesServerToMobileComplete(result: list);
}

Stream<dynamic> _downloadActions(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is SyncActionsServerToMobile)
      .asyncExpand((action) {
    return yieldResumeAction2(
        action,
        ActionsApi.getActions(action.runId, action.from, action.resumptionToken)
            .then((ARLearnActionsList list) {
          return list;
        }));
  });
}

Stream<dynamic> yieldResumeAction2(
    action, Future<ARLearnActionsList> futureList) async* {
  ARLearnActionsList list = await futureList;
  if (list.resumptionToken != null) {
    (action as SyncActionsServerToMobile).resumptionToken =
        list.resumptionToken!;
    print ('---syncing again ${list.responses.length}' );
    yield action;
    yield new SyncARLearnActionsListServerToMobileComplete(
        result: list,
        isLast: false
    );
  } else {
    print ('---resumption token null stop sync ${list.responses.length}');
    yield new SyncARLearnActionsListServerToMobileComplete(
        result: list,
        isLast: true
    );
  }

}

Stream<dynamic> _deleteResponse(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is DeleteResponseFromServer)
      .asyncMap((action) async {
    Response resp = await ResponseApi.deleteResponse(action.responseId);
    if (resp.responseId != null) {
      return new DeleteResponseFromLocalStore(responseId: resp.responseId!);
    }
  });
}
