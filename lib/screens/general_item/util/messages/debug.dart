import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'package:youplay/store/state/run_state.dart';

class VisibleItemModel {
  int nextItemId;
  List<ItemTimes> itemTimes;
  Run currentRun;
  HashMap<int, GamesState> gamesState;
  int gameId;

  VisibleItemModel(
      {this.nextItemId, this.itemTimes, this.currentRun, this.gamesState, this.gameId});

  static VisibleItemModel fromStore(Store<AppState> store) {
    int nextItemInt = nextItem1(store.state);
    List<ItemTimes> times = currentGeneralItems(store.state);
    Run run = currentRunSelector(store.state.currentRunState);
    HashMap<int, GamesState> gs = gameStateMap(store.state);
    int g = currentGameId(store.state);
    return new VisibleItemModel(
        nextItemId: nextItemInt,
        itemTimes: times,
        currentRun: run,
        gamesState: gs,
        gameId:g

    );
  }
}

class VisibleItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, VisibleItemModel>(
        converter: (store) => VisibleItemModel.fromStore(store),
        builder: (context, VisibleItemModel state) {
          List<Text> top = [Text("t1 ${state.nextItemId}")];
          print("hallo ${state.itemTimes}");

//          List<ItemTimes> newTimes = calcAlternative(state.gamesState, state.gameId, state.currentRunState);
//          List<Text> times = newTimes.map((item) { //state.itemTimes
//            int index = item.generalItem.title.length;
//            if (index > 10) {
//              index = 10;
//            }
//            ;
//            return new Text(
//                "${item.generalItem.itemId} ${item.generalItem.title.substring(0, index)} ${item.appearTime}");
//          }).toList();
//
//          List<Text> actions =
//              state.currentRunState.actionsFromServer.keys.map((key) {
//            ARLearnAction action = state.currentRunState.actionsFromServer[key];
//            return new Text("act ${action.generalItemId} ${action.action}");
//          }).toList();

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [top].expand((x) => x).toList(),
          );
        });
  }

  List<ItemTimes> calcAlternative(
      HashMap<int, GamesState> games, int gameId, RunState runState) {
    if (games[gameId] == null || games[gameId].game == null) {
      return [];
    }
    List<ItemTimes> visibleItems = [];
    games[gameId].itemIdToGeneralItem.forEach((key, GeneralItem item) {
      int localVisibleAt = item.visibleAt(runState.actionsFromServer);
      int localInvisibleAt = item.disapperAt(runState.actionsFromServer);
      int now = new DateTime.now().millisecondsSinceEpoch;
      if (localVisibleAt != -1 && now > localVisibleAt) {
        if (localInvisibleAt == -1 || localInvisibleAt > now) {
          visibleItems
              .add(ItemTimes(generalItem: item, appearTime: localVisibleAt));
        }
      }
    });
    visibleItems.sort((a, b) {
      return b.appearTime.compareTo(a.appearTime);
//    return a.appearTime < b.appearTime?-1: (a.appearTime > b.appearTime)?-1:0;
    });
    return visibleItems;
  }
}
