import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.dart';
import 'package:youplay/screens/util/navigation_drawer.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

class OutGoingPictureResponses extends StatelessWidget {
//  final Store<AppState> store;

  OutGoingPictureResponses();

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
              drawer: ARLearnNavigationDrawer(),

              appBar:  ThemedAppBar(title: 'Game state*', elevation: true),
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.file_upload),
                  onPressed: () {
                    print("about to upload files");
//                      store.dispatch(new SyncFileResponse(runId: map["runstate"].run.runId));
                  }),
              body: drawFunctionGS(map)

            );
          });
  }

  convertFunctionGS() {

    return (Store<AppState> store) =>
    {
      "keys": currentRunPictureResponsesSelector(store.state),
      "title" : store.state.currentGameState.game.title,
      "item" : store.state.currentGameState.itemIdToGeneralItem,
      "itemTimes" : currentGeneralItems(store.state),
      "actionsFromServerSel": actionsFromServerSel(store.state),
      "responsesFromServerSelector": responsesFromServerSelector(store.state),
      "allResponsesFromServerAsList": allResponsesFromServerAsList(store.state),
      "itemResponses" : currentItemResponsesFromServerAsList(store.state),
      "store": store
    };
  }

  drawFunctionGS(map) {
    HashMap<int, GeneralItem> hm = map["item"];
    HashMap<String, ARLearnAction> actionsFromServer = map["actionsFromServerSel"];
    List<ItemTimes> visibleItems = [];
    hm.forEach((key, GeneralItem item) {
      int localVisibleAt = item.visibleAt(actionsFromServer);
      int localInvisibleAt = item.disapperAt(actionsFromServer);
      int now = new DateTime.now().millisecondsSinceEpoch;
      if (localVisibleAt != -1 && now > localVisibleAt) {
        if (localInvisibleAt == -1 || localInvisibleAt > now) {
          visibleItems
              .add(ItemTimes(generalItem: item, appearTime: localVisibleAt));
        }
      }
    });

    List<String> litems = [
      "${map["title"]}",
      "${map["title"]}",
//      "${hm}",
      "${map["responsesFromServerSelector"]}",
      "${map["allResponsesFromServerAsList"]}",
      "${map["itemResponses"]}",
//      "items: ${map["item"]}","${actionsFromServer}","4"
//      , "${visibleItems[0].generalItem.title}"
    ];

    return Center(
      child: new ListView.builder
        (
          itemCount: litems.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Text(litems[index]);
          }
      ),
    );
  }


  convertFunction() {
    return (store) =>
    {
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
              'entry $index ${map["keys"][index]
                  .userId} ${map["keys"][index].toString()}');
        },
      ),
    );
  }
}
