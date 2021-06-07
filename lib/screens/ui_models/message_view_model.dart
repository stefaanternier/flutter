
import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:youplay/selectors/ui_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';

class MessageViewModel {
  Game game;
  int messageView;
  List<ItemTimes> items=[];
  List<ItemTimes> mapItems=[];
  Run run;
  final Store<AppState> store;
  List<LocationTrigger> points;
  Color themePrimaryColor;
//  Function onload;
  Function onLocationFound;
  MessageViewModel(
      {this.game,
        this.messageView,
        this.items,
        this.mapItems,
        this.store,
        this.run,
//      this.onload,
      this.themePrimaryColor,
        this.points,
        this.onLocationFound});

  getLocations() {
    print("get locations");
    return this.points;
  }

  giItemTapAction(GeneralItem item,  BuildContext context) {
    return () {
      print("on tap");
      store.dispatch(SetCurrentGeneralItemId(item.itemId));

      store.dispatch(new ReadItemAction(
          runId: run.runId,
          generalItemId: item.itemId));
      new Future.delayed(const Duration(milliseconds: 200), () {
        //todo this is an adhoc solution
        store.dispatch(new ReadItemAction(
            runId: run.runId,
            generalItemId: item.itemId));
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GeneralItemScreen()),
      );
    };
  }

  itemTapAction(int itemId, BuildContext context) {
    return () {
      store.dispatch(SetCurrentGeneralItemId(itemId));
      store.dispatch(new ReadItemAction(
          runId: run.runId,
          generalItemId: itemId));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GeneralItemScreen()),
      );
    };
  }

  static MessageViewModel fromStore(Store<AppState> store) {
//    print("test on run ${currentRunStateSelector(store.state)}");
    int runId = runIdSelector(store.state.currentRunState);

//    if (currentRunStateSelector(store.state) != null) {
//      runId = currentRunStateSelector(store.state).run.runId;
//    }

    return new MessageViewModel(
        game: gameSelector(store.state.currentGameState),

//        messageView: messagesView(store.state),
        store: store,
        run: currentRunSelector(store.state.currentRunState),
        items: listOnlyCurrentGeneralItems(store.state),
        mapItems: mapOnlyCurrentGeneralItems(store.state),
      themePrimaryColor: gameThemePrimaryColorSelector(store.state.currentGameState),
//        points: gameLocationTriggers(store.state),
//        onLocationFound: (double lat, double lng, int radius) {
//          if (runId !=-1){
//            store.dispatch(
//                LocationAction(lat: lat, lng: lng, radius: radius, runId: runId));
//          }
//        }
        );
  }


  Color getPrimaryColor() {

    return themePrimaryColor;
  }
}
