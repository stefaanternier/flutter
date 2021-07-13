import 'dart:convert';

import 'package:youplay/actions/errors.dart';
import 'package:youplay/api/general_items.dart';
import 'package:youplay/models/general_item.dart';

import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/store/state/app_state.dart';

//final gameGeneralItemEpic = new TypedEpic<AppState, ApiGameGeneralItems>(_addGame);

//Stream<dynamic> _addGame(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions.where((action) => action is ApiGameGeneralItems).asyncMap(
//          (action) => GeneralItemsApi.generalItems(action.gameId, store.state.authentication.idToken)
//          .then(
//                  (results) {
//                    downloadImages(results);
////                    print("AFTER ASYNC");
//                    return new ApiResultGameGeneralItems(results, action.gameId);}
//
//          )
//          .catchError((error) => new ApiResultError(error:error)));
//}

//todo cache images
downloadImages(results) async {

  var generalItemsList =jsonDecode(results);
  (generalItemsList['generalItems'] as List)
      .forEach((itemJson){
    GeneralItem item = GeneralItem.fromJson(itemJson);
    print("DOWNLOADING item ${item.title}");
//    DefaultCacheManager().getSingleFile("https://storage.googleapis.com/arlearn-eu.appspot.com/game/${item.gameId}/generalItems/${item.itemId}/background.jpg");
//    DefaultCacheManager().getSingleFile("https://storage.googleapis.com/arlearn-eu.appspot.com/game/${item.gameId}/generalItems/${item.itemId}/icon.jpg");
  });



}

final runVisibleItems = new TypedEpic<AppState, ApiRunsVisibleItems>(_visibleItems);

Stream<dynamic> _visibleItems(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is ApiRunsVisibleItems).asyncMap(
          (action) => GeneralItemsApi.visibleItems(action.runId)
          .then((results) => new ApiResultRunsVisibleItems(results, action.runId))
          .catchError((error) => new ApiResultError(error:error, message: 'error in loading visible items')));
}
