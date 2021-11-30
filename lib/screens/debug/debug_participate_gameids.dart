

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/selectors/all_games.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';

class GameParticipateIds extends StatelessWidget {
//  final Store<AppState> store;

  GameParticipateIds();

  @override
  Widget build(BuildContext context) {
    return
//      new StoreProvider(
//        store: store,
//        child:
        new StoreConnector<AppState, dynamic>(
            converter: convertFunctionGS(),
            builder: (context, map) {
              return new Scaffold(
                  drawer: ARLearnNavigationDrawerContainer(),
                  appBar: AppBar(
                    title: Text("Game participate Ids"),
                  ),
                  floatingActionButton: FloatingActionButton(
                      child: Icon(Icons.file_upload),
                      onPressed: () {
                        print("about to upload files");
//                      store.dispatch(new SyncFileResponse(runId: map["runstate"].run.runId));
                      }),
//                  body: ReduxDevTools<AppState>(map["store"]));
                  body: drawFunctionGS(map));
            });
  }

  convertFunctionGS() {
    return (Store<AppState> store) => {
          "test": "test",
          "ids": participateGameIdsSelector(store.state.allGamesState),
      "syncIds" : downloadedGameIdsSelector(store.state.allGamesState),
      "unSynced" : unSyncedGames(store.state.allGamesState),
      "fiu" : firstUnsyncedGameId(store.state.allGamesState),
      "store" : store
//      "title" : store.state.currentGameState.game.title,
//      "item" : store.state.currentGameState.itemIdToGeneralItem,
//      "itemTimes" : currentGeneralItems(store.state),
//      "actionsFromServerSel": actionsFromServerSel(store.state)
        };
  }

  drawFunctionGS(map) {
    print(map);
    List<String> litems = [
      "testtest",
      "${map["ids"]}",
      "${map["syncIds"]}",
      "unsynced ${map["unSynced"]}",
      "first uns ${map["fiu"]}",

    ];

    return Center(
      child: new ListView.builder(
          itemCount: litems.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Text(litems[index]);
          }),
    );
  }

  convertFunction() {
    return (store) => {
          "keys": currentRunPictureResponsesSelector(store.state),
//              "runstate": currentRunStateSelector(store.state)
        };
  }

  drawFunction(map) {
    return Center(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemExtent: 20.0,
        itemCount: map["keys"].length,
        itemBuilder: (BuildContext context, int index) {
          return Text(
              'entry $index ${map["keys"][index].userId} ${map["keys"][index].toString()}');
        },
      ),
    );
  }
}
