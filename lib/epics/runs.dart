import 'package:youplay/actions/run_users.dart';
import 'package:youplay/api/runs.dart';
import 'package:youplay/api/run_users.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/store/state/app_state.dart';
import 'dart:convert';
import 'dart:io';

final runsParticipateEpic =
    new TypedEpic<AppState, ApiRunsParticipateAction>(_gameParticipateStream);

Stream<dynamic> _gameParticipateStream(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is ApiRunsParticipateAction).asyncMap((action) {
    AppConfig().analytics.logJoinGroup(groupId: '${action.gameId}');
    return RunsApi.participate(action.gameId).then(
        (results) => new ApiResultRunsParticipateAction(runs: results, gameId: action.gameId));
  });
}

final runUsersEpic = new TypedEpic<AppState, ApiRunsUsersAction>(_runUsers);

Stream<dynamic> _runUsers(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is ApiRunsUsersAction).asyncExpand((action) {
    return _loadRunActionStream(UsersApi.runUsers().then((results) => results));
  });
}

Stream<dynamic> _loadRunActionStream(Future<dynamic> results) async* {
//  results.then((resultsToDecode) {
  var resultsList = jsonDecode(await results);
  List<dynamic> users = resultsList["users"];
  for (int i = 0; i < users.length; i++) {
    yield new ApiLoadRunAction(int.parse(users[i]['runId']));
  }
}

final getRunEpic = new TypedEpic<AppState, ApiLoadRunAction>(_getRunViaRunId);

Stream<dynamic> _getRunViaRunId(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is ApiLoadRunAction).asyncMap((action) =>
      RunsApi.runWithGame(action.runId)
          .then((results) => new ApiResultLoadRunAction(action.runId, results)));
//          .catchError((error) =>
//              new ApiResultRunsParticipateAction(error, action.runId)));
}
//
//final uploadResponseFilesEpic =
//    new TypedEpic<AppState, SyncFileResponse>(_uploadReponseFilesEpic);
//Stream<dynamic> _uploadReponseFilesEpic(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions
//      .where((action) => action is SyncFileResponse)
//      .asyncMap(((action) async {
//    if (store
//        .state.runIdToRunState[action.runId].outgoingPictureResponses.isNotEmpty) {
//      PictureResponse firstResponse = store
//          .state.runIdToRunState[action.runId].outgoingPictureResponses
//          .removeLast();
//      try {
//        final File file = await File(firstResponse.path).create();
//        String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
//        final StorageReference ref =
//            store.state.storage.ref().child('gameId').child(timeStamp + '.jpg');
//        final StorageUploadTask uploadTask = ref.putFile(
//          file,
//          StorageMetadata(
//            contentLanguage: 'en',
//            customMetadata: <String, String>{'description': 'User picture'},
//          ),
//        );
//        return uploadTask.onComplete.then((StorageTaskSnapshot snap) {
//          firstResponse.location = "gs://"+snap.storageMetadata.bucket+"/"
//              +snap.storageMetadata.path+"/"+snap.storageMetadata.name;
//          return new GenericResponseMetadataAction(
//                response: firstResponse );
//        });
//      } catch (e) {
//        store.state.runIdToRunState[action.runId].outgoingPictureResponses
//            .add(firstResponse);
//      }
//    }
//  }));
////          .then((results) => new ApiResultLoadRunAction(action.runId, results))
////          .catchError((error) => new ApiResultRunsParticipateAction(error, action.runId)));
//}
