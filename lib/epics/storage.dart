import 'package:youplay/actions/errors.dart';
import 'package:youplay/actions/run_users.dart';
import 'package:youplay/api/games.dart';
import 'package:youplay/api/runs.dart';
import 'package:youplay/api/run_users.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/store/state/app_state.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

//final listGameContent =
//    new TypedEpic<AppState, SyncGameContent>(_listGameContent);
//final syncGameContent =
//    new TypedEpic<AppState, SyncGameContentResult>(_syncGameContent);
//final syncGameFile = new TypedEpic<AppState, SyncGameFile>(_syncGameFile);

//Stream<dynamic> _listGameContent(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  print("in list game content");
//  return actions
//      .where((action) => action is SyncGameContent)
//      .distinct((action1, action2)=> action1.gameId ==action2.gameId)
//      .asyncMap((action) => GamesApi.gameContent(
//                  action.gameId, store.state.authentication.idToken)
//              .then((results) {
//            Map<String, dynamic> resultsMap = jsonDecode(results);
//            if (resultsMap.containsKey("error")) {
//              return new ApiResultError(error:resultsMap["error"]["code"]);
//            }
//
//            return new SyncGameContentResult(
//                action.gameId, resultsMap["gameFiles"] as List);
//          }).catchError((error) => new ApiResultError(error:error)));
//}

//Stream<dynamic> _syncGameContent(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions
//      .where((action) => action is SyncGameContentResult)
//      .asyncExpand((action) {
//    return _listToIndividualActions(action.gameFiles, action.gameId);
//  });
//}
//
//Stream<dynamic> _listToIndividualActions(dynamic jsonResults, int gameId) async* {
//  if (jsonResults!= null){
//    for (int i = 0; i < jsonResults.length; i++) {
//
//    }
//  }
//
//}

//Stream<dynamic> _syncGameFile(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions
//      .where((action) => action is SyncGameFile)
//      .asyncMap((action) {
////        print("syncing gf ${action.gameId} ${action.path}");
//        _downloadFile(store, action.path, action.gameId);
//  });
//}


// Future<void> _downloadFile(EpicStore<AppState> store, final String filePath, int gameId) async {
//   final StorageReference ref = store.state.storage.ref().child('game/$gameId/'+filePath);
//   final String url = await ref.getDownloadURL();
//   final http.Response downloadData = await http.get(url);
//   final Directory systemTempDir = Directory.systemTemp;
//   final File tempFile = File('${systemTempDir.path}/game/$gameId'+filePath);
//   //tempFile.createSync(recursive: true);
//   if (tempFile.existsSync()) {
//     await tempFile.delete();
//   }
//   await tempFile.create(recursive: true);
//   assert(await tempFile.readAsString() == "");
//   final StorageFileDownloadTask task = ref.writeToFile(tempFile);
//
//   final String tempFileContents = await tempFile.readAsString();
//
//
//   final String fileContents = downloadData.body;
//   final String name = await ref.getName();
//   final String bucket = await ref.getBucket();
//   final String path = await ref.getPath();
//   print(
//       'Success!\n Downloaded $name \n from url: $url @ bucket: $bucket\n '
//           'at path: $path \n\nFile contents: "$fileContents" \n'
//           'Wrote "$tempFileContents" to tmp.txt'
//
//     );
//
// }
