import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/components/game_play/messages_map_view.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/screens/util/location/context2.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

import 'messages_list_view.dart';

class MessageListContainer extends StatefulWidget {
  int listType;

  MessageListContainer({this.listType});

  @override
  _MessageListContainerState createState() => _MessageListContainerState();
}

class _MessageListContainerState extends State<MessageListContainer> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        int now = new DateTime.now().millisecondsSinceEpoch;
        List<ItemTimes> items = vm.items
            .where((element) => (element.appearTime < now))
            .toList(growable: false);
        vm.items
            .where((element) => (element.appearTime > now))
            .forEach((itemTime) {
          new Future.delayed(
              Duration(milliseconds: (itemTime.appearTime - now)), () {
            setState(() {});
          });
        });
        if (widget.listType == 1) {
          return MessagesList(
            items: items,
            tapEntry: vm.tapEntry,
          );
        }
        return LocationContext.around(
            MessagesMapView(
              items: items,
              tapEntry: vm.tapEntry,
            ),
            vm.points,
            vm.onLocationFound);
      },
    );
  }
}

class _ViewModel {
  List<ItemTimes> items = [];
  Function tapEntry;
  List<LocationTrigger> points;
  Function onLocationFound;

  // int runId;

  _ViewModel({this.items, this.tapEntry, this.points, this.onLocationFound});

  static _ViewModel fromStore(Store<AppState> store) {
    int runId = runIdSelector(store.state.currentRunState);
    return _ViewModel(
        points: gameLocationTriggers(store.state),
        onLocationFound: (double lat, double lng, int radius) {
          if (runId != -1) {
            store.dispatch(LocationAction(
                lat: lat, lng: lng, radius: radius, runId: runId));
          }
        },
        items: currentGeneralItems(store.state),
        tapEntry: (BuildContext context, GeneralItem item) {
          AppConfig().analytics.logViewItem(
              itemId: '${item.itemId}',
              itemName: '${item.title}',
              itemCategory: '${item.gameId}');

          store.dispatch(SetCurrentGeneralItemId(item.itemId));
          store.dispatch(
              new ReadItemAction(runId: runId, generalItemId: item.itemId));
          store.dispatch(new SyncResponsesServerToMobile(
            runId: runId,
            generalItemId: item.itemId,
          ));
          // print('hier');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GeneralItemScreen()),
          );
        });
  }
}
